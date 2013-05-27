class AccountController < ApplicationController
  before_filter :authenticate_user!

  def edit
    # profile information
    @user = User.find(current_user.id)

    # social providers
    @providers_suggested = %w[persona twitter facebook google]
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
end
