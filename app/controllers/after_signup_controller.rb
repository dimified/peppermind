class TemporaryUser
  attr_accessor :display_name, :email
end

class AfterSignupController < ApplicationController
  def index
    if session[:user_provider]
      @user = TemporaryUser.new
      @user.display_name = session[:user_display_name]
      @user.email = session[:user_email]

      render 'index'
    else
      redirect_to root_path
    end
  end

  def create
    # create user
    user = User.create email: params[:temporary_user][:email], password: params[:temporary_user][:password], display_name: params[:temporary_user][:display_name]
    user.socialproviders.create provider: session[:user_provider], uid: session[:user_uid], display_name: params[:temporary_user][:display_name], email: params[:temporary_user][:email]

    # create flash message
    flash[:notice] = t('authentication.social.created', provider: session[:user_provider].capitalize)

    # delete session variables
    session.delete(:user_display_name)
    session.delete(:user_email)
    session.delete(:user_provider)
    session.delete(:user_uid)

    # sign in and redirect
    sign_in_and_redirect :user, user
  end
end
