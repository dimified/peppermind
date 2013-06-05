class InspirationsController < ApplicationController
  load_and_authorize_resource
  rescue_from Mongoid::Errors::DocumentNotFound, :with => :access_denied
  before_filter :authenticate_user!

  def show
    @challenge = Challenge.find(params[:challenge_id])
    @inspiration = Inspiration.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @inspiration }
    end
  end

  def new
    @challenge = Challenge.find(params[:challenge_id])
    @inspiration = Inspiration.new

    respond_to do |format|
      format.html
      format.json { render json: @inspiration }
    end
  end

  def edit
    @challenge = Challenge.find(params[:challenge_id])
    @inspiration = Inspiration.find(params[:id])
  end

  def create
    @challenge = Challenge.find(params[:challenge_id])
    @inspiration = Inspiration.new(params[:inspiration])
    @inspiration.user = current_user
    @inspiration.challenge = @challenge

    respond_to do |format|
      if @inspiration.save
        track_activity @inspiration
        format.html { redirect_to challenge_path(@challenge), notice: t('challenge_inspirations.created') }
        format.json { render json: challenge_path(@challenge), status: :created, location: @inspiration }
      else
        format.html do
          flash[:error] = @inspiration.errors.full_messages.to_sentence + '.'
          render 'new'
          flash.discard :error
        end
        format.json { render json: challenge_path(@challenge).errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @challenge = Challenge.find(params[:challenge_id])
    @inspiration = Inspiration.find(params[:id])

    respond_to do |format|
      if @inspiration.update_attributes(params[:inspiration])
        format.html { redirect_to challenge_inspiration_path(@challenge, @inspiration), notice: t('challenge_inspirations.updated') }
        format.json { head :no_content }
      else
        format.html do
          flash[:error] = @inspiration.errors.full_messages.to_sentence + '.'
          render 'edit'
          flash.discard :error
        end
        format.json { render json: challenge_inspiration_path(@challenge, @inspiration).errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @challenge = Challenge.find(params[:challenge_id])
    @inspiration = Inspiration.find(params[:id])
    @inspiration.destroy

    respond_to do |format|
      format.html { redirect_to challenge_path(@challenge), notice: t('challenge_inspirations.deleted') }
      format.json { head :no_content }
    end
  end

  private

  def access_denied
    redirect_to challenge_path(params[:challenge_id]), flash: { error: t('inspirations.alert.missing') }
  end
end
