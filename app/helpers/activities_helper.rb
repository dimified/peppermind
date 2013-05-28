module ActivitiesHelper
	def tracked_inspiration(trackable_id)
		Inspiration.find(trackable_id)
	end

	def activity_link(type, trackable_id)
    item = eval(type).find(trackable_id)
		if type == "Challenge"
			challenge_path(item)
		elsif type == "Inspiration"
		  challenge_inspiration_path(item.challenge, item)
		end
	end
end
