module ApplicationHelper
  def current_translations
    @translations ||= I18n.backend.send(:translations)
    @translations[I18n.locale].with_indifferent_access
  end

  def devise_mapping
  	Devise.mappings[:user]
	end

	def resource_name
  	devise_mapping.name
  end

  def title(page_title)
    content_for(:title, page_title.to_s + ' - ' + Rails.application.class.parent_name)
    content_tag(:h1, page_title)
  end

  def time(time, options = {})
    options[:class] ||= 'time'
    content_tag(:time, l(time), options.merge(:datetime => time.strftime('%Y-%m-%dT%H:%M:%S%z'))) if time
  end
end
