# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	
	def allow_write_global
		acting_user.administrator?
	end
	
	def allow_write_collection
		allow_write_global
	end
	
	def allow_write_record
		allow_write_global
	end

	def allow_read_global
		true
	end
	
	def allow_read_collection(field)
		allow_read_global
	end
	
	def allow_read_record(field)
		allow_read_global
	end

end
