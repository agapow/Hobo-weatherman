class RemoveTimestampsFromFeatures < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end

    remove_column :bioseqfeatures, :updated_at
    remove_column :bioseqfeatures, :created_at
    change_column :bioseqfeatures, :name, :string, :limit => 64
  end

  def self.down
    add_column :bioseqfeatures, :updated_at, :datetime
    add_column :bioseqfeatures, :created_at, :datetime
    change_column :bioseqfeatures, :name, :string, :limit => 32

    drop_table :projects
  end
end
