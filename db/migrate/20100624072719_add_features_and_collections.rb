class AddFeaturesAndCollections < ActiveRecord::Migration
  def self.up
    create_table :bioseqcollections do |t|
      t.string   :identifier
      t.string   :source
      t.string   :title
      t.string   :description
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :bioseqfeatures do |t|
      t.string   :name
      t.string   :value
      t.integer  :start
      t.integer  :stop
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :bioseqcollections
    drop_table :bioseqfeatures
  end
end
