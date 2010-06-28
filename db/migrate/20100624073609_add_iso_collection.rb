class AddIsoCollection < ActiveRecord::Migration
  def self.up
    create_table :isolatecollections do |t|
      t.string   :identifier
      t.string   :source
      t.string   :title
      t.string   :description
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :isolatecollections
  end
end
