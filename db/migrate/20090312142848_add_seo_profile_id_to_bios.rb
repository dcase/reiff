class AddSeoProfileIdToBios < ActiveRecord::Migration
  def self.up
    add_column :bios, :seo_profile_id, :integer
  end

  def self.down
    remove_column :bios, :seo_profile_id
  end
end
