set :path, '/Users/dimitrireifschneider/Development/peppermind'
set :output, '/Users/dimitrireifschneider/Development/peppermind/log/cron.log'
set :environment, 'development' 

every 1.minute do
	runner 'Challenge.is_over'
end

# every :day, at: '00:00am' do
#   runner 'Challenge.is_over'
# end
