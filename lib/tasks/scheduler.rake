desc "This task is called by Heroku and is the productive implementation of whenever cronjobs"

task :rewards => :environment do
  puts "Starting Challenge.rewards"
  Challenge.rewards
  puts "done."
end