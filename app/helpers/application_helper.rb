### IMPORTS

require 'strscan'
require 'pp'

require 'bio'


### IMPLEMENTATION
# Methods added to this helper will be available to all templates in the
# application.

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

	# Layout a biosequence appropriate for display within HTML.
	#
	# [seq_str] the biosequence to be formatted, as a string
	#
	# [line_width] how long a line to 'wrap' the sequence in
	# [block_width] the size of sections to break up a line into
	#
	# [returns] a 'naked' literal string to appear within a PRE or textarea
	#
	# A general layout technique for all biosequences. Numbering of positions
	# must be handled elsewhere.
	#
	def format_bioseq(seq_str, options={})
			  # there is probably a more rubyish way of doing this
		# string.scan doesn't pick up the residue

		## Preconditions & preparation:
		options = {
			:line_width => 60,
			:block_width => 10,
			:case => 'lower'
		}.merge(options)

		## Main:
		lines = []

		# change case of seq if need be
		case options[:case]
			when 'down', 'lower'
			  seq_str.downcase!()
			when 'up', 'upper'
			  seq_str.upcase!()
			when 'leave', nil
			  # do nothing
			else
			  # TODO: should error out here
		end

		# break up into lines
		line_scanner = StringScanner.new(seq_str)
		line_re = Regexp.new(".{0,#{options[:line_width]}}")
		while not line_scanner.eos?
			curr_line = line_scanner.scan(line_re)

			# format into blocks if required
			if options[:block_width] and (0 < options[:block_width])
			  block_re = Regexp.new(".{0,#{options[:block_width]}}")
			  block_scanner = StringScanner.new(curr_line)
			  blocks = []
			  while not block_scanner.eos?
			    curr_block = block_scanner.scan(block_re)
			    blocks.push(curr_block)
			  end
			  # fuse into line
			  curr_line = blocks.join(' ')
			end

			lines.push(curr_line)
		end

		## Return:
		wrapped_str = lines.join("\n")
		return wrapped_str
	end

	# Translate a nucleotide sequence into a protein sequence.
	#
	# [nucseq_str] the sequence to be converted
	# [frame] what frame, in BioRuby terms, to use
	#
	# [returns] a translated string
	#
	def translate_nucseq (nuc_str, frame=1)
		nuc_seq = Bio::Sequence::NA.new(nuc_str)
		return nuc_seq.translate(frame).to_str()
	end

	# Generate the position numbers for showing on the row ends of formatted bioseqs.
	#
	# [line_width] how wide is the sequence formatted
	# [line_cnt] how many rows to supply numbers for
	#
	# [char_width] how many positions a single character is (3 for amino acids)
	# [start_posn] what the first displayed position is
	#
	# [returns] two arrays, for the left and right sides respectively
	#
	def row_numbers (line_width, line_cnt, options={})
		# TODO: do we get a speedup if we just lookup options hash once?
		# TODO: calculate last righthand position to end of sequence?
		# TODO: cope with missing positions and the like?

		## Preconditions & preparation:
		options = {
			:char_width => 1,
			:start_posn => 1,
			:max_index => false,
		}.merge(options)
		
		## Main:
		posn_width = (line_cnt * line_width * options[:char_width]).to_s.length()
		line_range = (0...line_cnt)

		left_posns = line_range.map { |e|
			"%*s" % [posn_width, (e*line_width*options[:char_width]) +
				options[:start_posn]]
		}.join("\n")
		
		# so the last righthand figure is set to something sensible
		if options[:max_index]
			max_right_posn = options[:max_index]
		else
			max_right_posn = line_cnt * line_width * options[:char_width]
		end
		right_posns = line_range.map { |e|
			"%*s" % [posn_width, [((e+1)* line_width * options[:char_width]) +
				(options[:start_posn] - options[:char_width]), max_right_posn].min()]
		}.join("\n")

		# Return:
		return left_posns, right_posns
	end

end
