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
	
  def sdfsdfsd
	 @collection = find_instance
	 @bioseqs = @collection.books.apply_scopes(:search => [params[:search], :title, :identifier],
		:order_by => parse_sort_param(:title, :author)).paginate(:per_page => 30,
		:page => params[:page])
  end
	
end
