class InspirationsController < ApplicationController
  load_and_authorize_resource

  rescue_from Mongoid::Errors::DocumentNotFound, :with => :access_denied

  def index
    @inspirations = Inspiration.all

    respond_to do |format|
      format.html
      format.json { render json: @inspirations }
    end
  end

  def show
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
    @inspiration = Inspiration.find(params[:id])
  end

  def create
    @challenge = Challenge.find(params[:challenge_id])
    @inspiration = Inspiration.new(user: current_user, challenge: @challenge, description: params[:inspiration]['description'])

    respond_to do |format|
      if @inspiration.save
        track_activity @inspiration
        format.html { redirect_to challenge_inspiration_path(@challenge, @inspiration), notice: t('challenge_inspirations.created') }
        format.json { render json: challenge_inspiration_path(@challenge, @inspiration), status: :created, location: @inspiration }
      else
        format.html { render action: 'new' }
        format.json { render json: @inspiration.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @inspiration = Inspiration.find(params[:id])

    respond_to do |format|
      if @inspiration.update_attributes(params[:inspiration])
        format.html { redirect_to challenge_inspiration_path(params[:challenge_id], @inspiration), notice: t('challenge_inspirations.updated') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @inspiration.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @inspiration = Inspiration.find(params[:id])
    challenge = @inspiration.challenge_id
    @inspiration.destroy

    respond_to do |format|
      format.html { redirect_to challenge_path(challenge), notice: t('challenge_inspirations.deleted') }
      format.json { head :no_content }
    end
  end

  private

  def access_denied
    redirect_to challenge_path(params[:challenge_id]), flash: { error: t('inspirations.alert.missing') }
  end
end
