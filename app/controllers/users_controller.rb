class UsersController < ApplicationController
  before_filter :authenticate_user!
  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def show
    @user = current_user

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end
end
