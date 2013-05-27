module ActivitiesHelper
	def tracked_inspiration(trackable_id)
		Inspiration.find(trackable_id)
	end
end
