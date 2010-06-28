class Bioseqcollection < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    identifier  :string
    source      :string
    title       :string
    description :text
    timestamps
  end

  has_many :biosequences, :through => :bioseqcollection_biosequences,
    :accessible => true 
  has_many :bioseqcollection_biosequences, :dependent => :destroy

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

end
