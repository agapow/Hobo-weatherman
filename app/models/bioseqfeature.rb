class Bioseqfeature < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name  :string, :required, :limit => 32
    value :string, :required
    start :integer
    stop  :integer
    timestamps
  end

  belongs_to :biosequence

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
