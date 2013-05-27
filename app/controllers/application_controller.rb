class ApplicationController < ActionController::Base
  protect_from_forgery

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

  # Convert Date in human-readable format
  def convert_date(date)
    DateTime.parse(date.to_s).strftime('%d.%m.%Y')
  end

  def after_sign_in_path_for(resource)
    cookies[:login] = true
    user_path resource
  end

  def after_sign_out_path
    cookies.delete :login
    root_path
  end
end
