class AccountController < ApplicationController
  before_filter :authenticate_user!

  def edit
    # profile information
    @user = User.find(current_user.id)

    # social providers
    @providers_suggested = %w[persona facebook google]
    @providers_user = current_user.socialproviders.all

    @providers_user.each do | socialprovider |
      @providers_suggested.delete(socialprovider.provider)
    end
  end

  def update
    @user = User.find(current_user.id)

    respond_to do |format|
      unless params[:user][:display_name] === current_user.display_name
        @user.validate_display_name(params[:user][:display_name])
      end

      if @user.errors.empty?
        @user.update_attribute(:display_name, params[:user][:display_name])
        format.html { redirect_to account_edit_path, notice: t('account.validation.success') }
        format.json { head :no_content }
      else
        format.html { redirect_to account_edit_path, flash: { error: @user.errors[:display_name].first.to_s } }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # remember user id and delete cookie
    user_id = current_user.id
    cookies.delete :user_id

    # delete user and her/his activities
    Activity.where(user_id: user_id).destroy
    User.find(user_id).destroy

    # change ownership of challenges and inspirations
    peppermind_user = User.first.id

    Challenge.where(user_id: user_id).update_all(user_id: peppermind_user)
    Inspiration.where(user_id: user_id).update_all(user_id: peppermind_user)

    # show success message and redirect to root path
    respond_to do |format|
      format.html { redirect_to root_path, notice: t('account.edit.delete_account.success') }
      format.json { head :no_content }
    end
  end

  def edit_password
    @user = current_user
  end

  def update_password
    @user = User.find(current_user.id)

    respond_to do |format|
      @user.validate_password(params[:user][:password])
      @user.password_match?(params[:user][:password], params[:user][:password_confirmation])

      if @user.errors.empty? && @user.update_with_password(params[:user])
        format.html do
          sign_in @user, bypass: true
          redirect_to user_path(@user), notice: t('account.validation.success')
        end
        format.json { head :no_content }
      else
        format.html do
          errors = ''
          errors << t('account.validation.password.current') if @user.errors[:current_password]
          errors << @user.errors[:password].first.to_s if @user.errors[:password]
          errors << @user.errors[:password_confirmation].first.to_s if @user.errors[:password_confirmation]
          flash[:error] = errors
          redirect_to account_edit_password_path
        end
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
