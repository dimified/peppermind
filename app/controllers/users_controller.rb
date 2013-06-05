class UsersController < ApplicationController
  before_filter :authenticate_user!, only: :show
  rescue_from Mongoid::Errors::DocumentNotFound, with: :access_denied

  def index
    @users = User.all.order_by([:points, :desc])

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
    @challenges = Challenge.where(user_id: @user).order_by([:id, :desc]).limit(5)
    @inspirations = Inspiration.where(user_id: @user).limit(5).desc

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  private

  def access_denied
    redirect_to users_path, flash: { error: t('users.alert.missing') }
  end
end
