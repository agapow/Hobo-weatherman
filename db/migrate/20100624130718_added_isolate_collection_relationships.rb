class AddedIsolateCollectionRelationships < ActiveRecord::Migration
  def self.up
    create_table :isolatecollection_isolates do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :isolate_id
      t.integer  :isolatecollection_id
    end
    add_index :isolatecollection_isolates, [:isolate_id]
    add_index :isolatecollection_isolates, [:isolatecollection_id]
  end

  def self.down
    drop_table :isolatecollection_isolates
  end
end
