class ResizedBseqFields < ActiveRecord::Migration
  def self.up
    change_column :bioseqfeatures, :name, :string, :limit => 32

    change_column :biosequences, :title, :string, :limit => 64
    change_column :biosequences, :identifier, :string, :limit => 32
    change_column :biosequences, :source, :string, :limit => 32
  end

  def self.down
    change_column :bioseqfeatures, :name, :string

    change_column :biosequences, :title, :string
    change_column :biosequences, :identifier, :string
    change_column :biosequences, :source, :string
  end
end
