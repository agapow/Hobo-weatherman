### IMPORTS ###

require 'pp'
require 'date'

require('dev_tools')


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
	
	#before_validation :clean_fields
	
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

	# --- Validators --- #
	
	def clean_seqdata(raw_val)
		clean_data = raw_val.strip.downcase.gsub(/\s+/, '').gsub('?', 'n')
		uniq_seq_chars = clean_data.split("").uniq()
		illegal_seq_chars = uniq_seq_chars - WeathermanDefs::IUPAC_DNA_CHARLIST
		if not illegal_seq_chars.empty?
			raise(ArgumentError,
				"data contains non-IUPAC symbols: #{illegal_seq_chars.join('')}")
		end
		return clean_data
	end
		
	include PrimaryObjModel
end
