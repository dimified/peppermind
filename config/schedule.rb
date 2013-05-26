set :output, '/log/cron.log'
set :environment, 'production' 

# development
every 1.minute do
	runner 'Challenge.is_over'
end

# production
# every :day, at: '00:00am' do
#   runner 'Challenge.is_over'
# end
