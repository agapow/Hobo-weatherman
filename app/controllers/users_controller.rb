class UsersController < ApplicationController

  hobo_user_controller

  auto_actions :all

	# --- Permissions --- #

	def create_permitted?
	 acting_user.administrator? 
	end

	def update_permitted?
		acting_user.administrator? 
	end

	def destroy_permitted?
	 acting_user.administrator? 
	end

	def view_permitted?(field)
		acting_user.administrator? 
	end
end
