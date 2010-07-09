class BiosequencesController < ApplicationController

  hobo_model_controller

  auto_actions :all

	# --- Permissions --- #

	def create_permitted?
		true
	end

	def update_permitted?
		true
	end

	def destroy_permitted?
		true
	end

	def view_permitted?(field)
		true
	end
end
