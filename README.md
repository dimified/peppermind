peppermind
==========

The Mobile Innovation Community for fresh ideas 

The application has a default user which must be initialized by `rake db:seed`.

Please create a `/config/env_vars.rb` file and define the following environment variables:

// secret token<br />
`ENV['SECRET_TOKEN']`

// mail settings. HOST = URL of the Peppermind page<br />
`ENV['MAIL_HOST']`<br />
`ENV['MAIL_USER']`<br />
`ENV['MAIL_PASS']`<br />

// social login keys<br />
`ENV['FACEBOOK_KEY']`<br />
`ENV['FACEBOOK_SECRET']`
