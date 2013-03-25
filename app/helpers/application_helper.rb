module ApplicationHelper
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
end
