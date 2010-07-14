### IMPORTS ###

require 'pp'
require 'date'


### CONSTANTS & DEFINES ###

 # format for UIDs
$uid_datetime_fmt = "%Y%m%d-%H%M%S"
$uid_base = 0


### IMPLEMENTATION ###

# Generate a unique identifer for this record.
#
def generate_uid(prefix="uid")
	$uid_base += 1
	date_str = DateTime::now().strftime($uid_datetime_fmt)
	return "#{prefix}.#{date_str}.#{$uid_base}"
end


class Biosequence < ActiveRecord::Base

	hobo_model # Don't put anything above this

	fields do
		identifier  :string, :limit => 32
		source		:string, :limit => 32
		title       :string, :limit => 64
		description :text
		seqdata     :text, :required
		timestamps
	end

	# --- Validations and data normalisation --- #
	
	has_many :bioseqfeatures,  :accessible => true, :dependent => :destroy
	
	has_many :bioseqcollections, :through => :bioseqcollection_biosequences
	has_many :bioseqcollection_biosequences, :dependent => :destroy
	
	validates_uniqueness_of :identifier, :scope => :source
	
	before_validation :clean_fields
	

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
	
		# Normalise and set default values for fields.
		#
		# You can't set dynamic defaults for rails, and normalisation needs to be
		# done before any validation. So we do it all here.
		#
		def clean_fields
			# generate an identifier if need be
			if (identifier.blank?)
				self.identifier = generate_uid(prefix="bseq")
			else
				self.identifier = identifier.strip()	
			end
			# trim, squish and downcase sequence data
			self.seqdata = seqdata.strip.downcase.gsub(/\s+/, '').gsub('?', 'n')
			# trim text fields
			self.title = title.strip()
			self.source = source.strip()
			self.description = description.strip()

			return true
		end
		
		def validate
			uniq_seq_chars = seqdata.split("").uniq()
			illegal_seq_chars = uniq_seq_chars - WeathermanDefs::IUPAC_DNA_CHARLIST
			if not illegal_seq_chars.empty?
				errors.add(:seqdata,
					"data contains non-IUPAC symbols: #{illegal_seq_chars.join('')}")
			end
		end
		
end
