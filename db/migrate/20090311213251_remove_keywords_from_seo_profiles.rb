class RemoveKeywordsFromSeoProfiles < ActiveRecord::Migration
  def self.up
    remove_column :seo_profiles, :keywords
  end

  def self.down
    add_column :seo_profiles, :keywords, :string
  end
end
