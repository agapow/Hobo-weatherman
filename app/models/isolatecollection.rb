class Isolatecollection < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    identifier  :string
    source      :string
    title       :string
    description :text
    timestamps
  end

  has_many :isolates, :through => :isolatecollection_isolates,
    :accessible => true 
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

end
