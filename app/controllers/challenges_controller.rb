class ChallengesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource
  rescue_from Mongoid::Errors::DocumentNotFound, with: :access_denied

  def index
    @challenges = Challenge.order_by([:created_at, :desc]).page params[:page]

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @challenges }
    end
  end

  def show
    @challenge = Challenge.find(params[:id])
    @challenge.duration_string = convert_date @challenge.duration
    @inspirations = Inspiration.where(challenge: @challenge).order_by([:like, :desc])

    respond_to do |format|
      format.html
      format.json { render json: @challenge }
    end
  end

  def new
    @challenge = Challenge.new

    respond_to do |format|
      format.html
      format.json { render json: @challenge }
    end
  end

  def edit
    @challenge = Challenge.find(params[:id])
    @challenge.duration_string = convert_date @challenge.duration
  end

  def create
    @challenge = current_user.challenges.build(params[:challenge])

    respond_to do |format|
      if @challenge.save
        track_activity @challenge
        session[:challenge_id] = @challenge.id
        format.html { redirect_to new_challenge_inspiration_path(@challenge), notice: t('challenges.alert.created') }
        format.json { render json: @challenge }
      else
        format.html do
          flash[:error] = @challenge.errors.full_messages.to_sentence + '.'
          redirect_to new_challenge_path
          flash.discard :error
        end
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @challenge = Challenge.find(params[:id])

    respond_to do |format|
      if @challenge.update_attributes(params[:challenge])
        track_activity @challenge
        format.html { redirect_to @challenge, notice: t('challenges.alert.updated') }
        format.json { head :no_content }
      else
        format.html do
          flash[:error] = @challenge.errors.full_messages.to_sentence + '.'
          render 'edit'
          flash.discard :error
        end
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @challenge = Challenge.find(params[:id])
    @challenge.destroy
    delete_activity @challenge

    respond_to do |format|
      format.html { redirect_to challenges_url, notice: t('challenges.alert.deleted') }
      format.json { head :no_content }
    end
  end

  private

  def access_denied
    redirect_to challenges_path, flash: { error: t('challenges.alert.missing') }
  end
end

