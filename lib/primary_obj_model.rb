

# A mixin for common methods for the main database objects.
#
# The main (primary) database objects share several fields and their associated
# methods (identifier, description, name). For efficacy, they are gathered here.
#
module PrimaryObjModel
	
	def source_id
		return "#{source.blank? ? '' : source + ':'}#{identifier}"
	end
	
	# Deliver a printable user-friendly name
	#
	# The scheme we use is this:
	# - the record must have an identifier, but need not have a source or title
	# - if there is a source, a src_id is produced from "source:identifier"
	# - else, the src_id is just the id
	# - if there is no title, or if the title equals the src_id, the name is
	#   just the src_id
	# - otherwise the name is "title (src_id)"
	#
	# So for these src / identifier / title triplets, we get the names:
	# - foo / bar / baz -> "baz (foo:bar)"
	# - / bar / baz -> "baz (bar)"
	# - / bar / bar -> "bar"
	# - bar / bar / bar -> "bar (bar:bar)"
	# - / bar / -> "bar"
	#	
	def name
		src_id = source_id()
		if not title.blank?
			if title == src_id
				return title
			else
				return "#{title} (#{src_id})"
			end
		else
			return src_id
		end
	end
	
	# A terse form of name where it is needed
	def short_name
		return title || source_id()
	end
	
	protected
	
		# You can't set dynamic defaults for rails, and normalisation needs to be
		# done before any validation. So we do it all here.
		#
		def clean_identifier(raw_id)
			if (raw_id.blank?)
				return generate_uid(prefix="bseq")
			else
				return identifier.strip()	
			end
		end
		
		def clean_title(raw_val)
			return raw_val.strip()	
		end
				
		def clean_source(raw_val)
			return raw_val.strip()	
		end
				
		def clean_description(raw_val)
			return raw_val.strip()	
		end
	
end
