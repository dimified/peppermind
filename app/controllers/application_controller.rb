class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  # Custom error page
  rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound do
    ErrorsController::render_404
  end

  # Show access denied alert
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => t('authentication.exception.access_denied')
  end

  # Track activities
  def track_activity(trackable, action = params[:action])
    current_user.activities.create! action: action, trackable: trackable
  end

  # Delete activities
  def delete_activity(trackable)
    current_user.activities.find(trackable).destroy
  end

  # Convert Date in human-readable format
  def convert_date(date)
    DateTime.parse(date.to_s).strftime('%d.%m.%Y')
  end

  def after_sign_in_path_for(resource)
    cookies[:user_id] = current_user.id unless cookies[:user_id]
    user_path resource
  end

  def after_sign_out_path_for(resoure)
    cookies.delete :user_id
    root_path
  end

  private

  def set_locale
    locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    if locale.match /^(de|en)$/
      I18n.locale = locale
    else
      I18n.locale = Rails.application.config.i18n.default_locale
    end
  end
end
