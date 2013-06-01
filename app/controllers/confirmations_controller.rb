class ConfirmationsController < Devise::ConfirmationsController
  def show
    self.resource = resource_class.where(confirmation_token: params[:confirmation_token]).first() if params[:confirmation_token].present?
    super if self.resource.nil? or self.resource.confirmed?
  end

  def confirm
    self.resource = resource_class.where(confirmation_token: params[resource_name][:confirmation_token]).first() if params[resource_name][:confirmation_token].present?
    if resource.update_attributes(params[resource_name].except(:confirmation_token)) && resource.password_match?(params[resource_name][:password], params[resource_name][:password_confirmation])
      self.resource = resource_class.confirm_by_token(params[resource_name][:confirmation_token])
      set_flash_message :notice, :confirmed
      sign_in_and_redirect(resource_name, resource)
    else
      render action: 'show'
    end
  end
end
