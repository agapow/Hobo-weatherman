class Isolate < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    identifier  :string, :required
    source      :string
    title       :string
    description :text
    serotype    :string
    host        :string
    country     :string
    region      :string
    timestamps
  end

  has_many :isolatecollections, :through => :isolatecollection_isolates
  has_many :isolatecollection_isolates, :dependent => :destroy
  
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
