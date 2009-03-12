class AddIsVerticalScrollToPageSections < ActiveRecord::Migration
  def self.up
    add_column :page_sections, :is_vertical_scroll, :boolean
  end

  def self.down
    remove_column :page_sections, :is_vertical_scroll
  end
end
