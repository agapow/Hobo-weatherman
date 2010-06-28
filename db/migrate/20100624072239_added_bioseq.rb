class AddedBioseq < ActiveRecord::Migration
  def self.up
    create_table :biosequences do |t|
      t.string   :identifier
      t.string   :source
      t.string   :title
      t.string   :description
      t.text     :seqdata
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :biosequences
  end
end
