class AddKeywordsToSeoProfiles < ActiveRecord::Migration
  def self.up
    add_column :seo_profiles, :keywords, :text
  end

  def self.down
    remove_column :seo_profiles, :keywords
  end
end
