class AddedFeatures < ActiveRecord::Migration
  def self.up
    add_column :bioseqfeatures, :biosequence_id, :integer

    add_index :bioseqfeatures, [:biosequence_id]
  end

  def self.down
    remove_column :bioseqfeatures, :biosequence_id

    remove_index :bioseqfeatures, :name => :index_bioseqfeatures_on_biosequence_id rescue ActiveRecord::StatementInvalid
  end
end
