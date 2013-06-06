peppermind
==========

The Mobile Innovation Community for fresh ideas 

The application has a default user which must be initialized by `rake db:seed`.

Please create a `/config/env_vars.rb` file and define the following environment variables:

// secret token
ENV['SECRET_TOKEN']

// mail settings. Host = URL of the Peppermind page
ENV['MAIL_HOST'] 
ENV['MAIL_USER']
ENV['MAIL_PASS']

// Social login keys
ENV['FACEBOOK_KEY']
ENV['FACEBOOK_SECRET']
