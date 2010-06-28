class WidenDescriptions < ActiveRecord::Migration
  def self.up
    change_column :bioseqcollections, :description, :text, :limit => nil

    change_column :biosequences, :description, :text, :limit => nil

    change_column :isolatecollections, :description, :text, :limit => nil

    add_column :isolates, :serotype, :string
    add_column :isolates, :host, :string
    add_column :isolates, :country, :string
    add_column :isolates, :region, :string
    change_column :isolates, :description, :text, :limit => nil
  end

  def self.down
    change_column :bioseqcollections, :description, :string

    change_column :biosequences, :description, :string

    change_column :isolatecollections, :description, :string

    remove_column :isolates, :serotype
    remove_column :isolates, :host
    remove_column :isolates, :country
    remove_column :isolates, :region
    change_column :isolates, :description, :string
  end
end
