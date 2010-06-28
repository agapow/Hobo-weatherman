class AddBseqcollectionInfrastructure < ActiveRecord::Migration
  def self.up
    create_table :bioseqcollection_biosequences do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :biosequence_id
      t.integer  :bioseqcollection_id
    end
    add_index :bioseqcollection_biosequences, [:biosequence_id]
    add_index :bioseqcollection_biosequences, [:bioseqcollection_id]
  end

  def self.down
    drop_table :bioseqcollection_biosequences
  end
end
