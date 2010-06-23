class Contact < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name      :string, :required
    company   :string
    address_1 :string 
    address_2 :string 
    city      :string 
    state     :string 
    date_met  :date 
    married   :boolean 
    age       :integer 
    notes     :text 
    timestamps
  end

  validates_numericality_of  :age
  
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
