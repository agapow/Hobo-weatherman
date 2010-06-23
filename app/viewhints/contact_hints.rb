class ContactHints < Hobo::ViewHints

  # model_name "My Model"
  # field_names :field1 => "First Field", :field2 => "Second Field"
  # field_help :field1 => "Enter what you want in this field"
  # children :primary_collection1, :aside_collection1, :aside_collection2
  
  field_names :name => "Friend", :address_1 => "Address"
  field_help :name => "Put your friend's name here.", 
	 :company => "Where does your friend work?",  
    :married_now => "Married or not?" 

end
