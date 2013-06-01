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
    # create new user and validate data
    @user = User.new(email: params[:temporary_user][:email], password: params[:temporary_user][:password], display_name: params[:temporary_user][:display_name])
    @user.validate_display_name(params[:temporary_user][:display_name])
    @user.validate_email(params[:temporary_user][:email], params[:temporary_user][:email_confirm])

    if @user.errors.empty?
      # save user and link social provider with account
      @user.save
      @user.socialproviders.create provider: session[:user_provider], uid: session[:user_uid], display_name: params[:temporary_user][:display_name], email: params[:temporary_user][:email]

      # create flash message
      flash[:notice] = t('authentication.social.created', provider: session[:user_provider].capitalize)

      # delete session variables
      session.delete(:user_display_name)
      session.delete(:user_email)
      session.delete(:user_provider)
      session.delete(:user_uid)

      # sign in and redirect
      sign_in_and_redirect :user, @user
    else
      # add error messages
      flash[:error] = ''
      flash[:error] += @user.errors[:display_name].first.to_s if @user.errors[:display_name]
      flash[:error] += @user.errors[:email].first.to_s if @user.errors[:email]
      flash[:error] += @user.errors[:email_confirm].first.to_s if @user.errors[:email_confirm]

      # redirect to after signup path
      redirect_to after_signup_index_path
    end
  end
end
