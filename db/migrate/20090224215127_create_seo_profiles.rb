class CreateSeoProfiles < ActiveRecord::Migration
  def self.up
    create_table :seo_profiles do |t|
      t.string :name
      t.string :title
      t.string :keywords
      t.text :description
      t.string :alt_prefix
      t.string :heading

      t.timestamps
    end
  end

  def self.down
    drop_table :seo_profiles
  end
end
