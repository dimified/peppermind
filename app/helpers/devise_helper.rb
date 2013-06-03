module DeviseHelper
  def devise_error_messages!
    html = ''

    resource.errors.each do |key, value|
      html << "#{value} "
    end

    html.html_safe
  end
end
