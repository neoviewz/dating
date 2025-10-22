class ApplicationController < ActionController::Base
	def after_sign_in_path_for(resource)
		if resource.is_a?(User)
			resource.profile ||= Profile.create!(user: resource)
			edit_profile_path(resource.profile)
		else
			super
		end
	end
end

class ApplicationController < ActionController::Base
end
