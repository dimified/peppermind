ActionMailer::Base.smtp_settings = {
  :address              => 'smtp.gmail.com',
  :port                 => 587,
  :domain               => ENV['MAIL_HOST'],
  :user_name            => ENV['MAIL_USER'],
  :password             => ENV['MAIL_PASS'],
  :authentication       => 'plain',
  :enable_starttls_auto => true
}
