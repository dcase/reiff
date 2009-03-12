class AddShowTitleToPageSections < ActiveRecord::Migration
  def self.up
    add_column :page_sections, :show_title, :boolean
  end

  def self.down
    remove_column :page_sections, :show_title
  end
end
