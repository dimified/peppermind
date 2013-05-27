module UsersHelper

  # gravatar helper
  def avatar(user, size = 32)
    default_url = "#{root_url}images/default_avatar.png"
    gravatar_hash = Digest::MD5.hexdigest(user.email.downcase) if user.email
    "http://gravatar.com/avatar/#{gravatar_hash}?s=#{size}&d=#{CGI.escape(default_url)}"
  end
end
