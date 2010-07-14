
class ActiveRecord::Base
		
	def validate
		pp methods.sort
		pp @class.methods.sort
		self.content_columns.each { |c|
			col_name = c.name
			clean_meth_name = "clean_#{col_name}"
			pp "looking for #{clean_meth_name} ..."
			if self.respond_to(clean_meth_name)
				pp "calling #{clean_meth_name} ..."
				self.send(clean_meth_name)
			end
			validate_meth_name = "validate_#{col_name}"
			pp "looking for #{validate_meth_name} ..."
			if self.respond_to(validate_meth_name)
				pp "calling #{validate_meth_name} ..."
				self.send(validate_meth_name)
			end
		}
	end
		
end