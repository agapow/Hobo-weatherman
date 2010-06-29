def gen_id
  return "foo"
end


class Biosequence < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    identifier  :string, :limit => 32, :default => gen_id
    source      :string, :limit => 32
    title       :string, :limit => 64
    description :text
    seqdata     :text, :required
    timestamps
  end

  has_many :bioseqfeatures
  
  has_many :bioseqcollections, :through => :bioseqcollection_biosequences
  has_many :bioseqcollection_biosequences, :dependent => :destroy
  
  validates_uniqueness_of :identifier, :scope => :source
  
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

  def name
    src_id = "#{source.blank? ? '' : source + ':'}#{identifier}"
    if title
      if title == src_id
        return title
      else
        return "#{title} (#{src_id})"
      end
    else
      return src_id
    end
  end
  
end
