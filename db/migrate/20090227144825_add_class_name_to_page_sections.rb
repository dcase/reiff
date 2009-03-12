class AddClassNameToPageSections < ActiveRecord::Migration
  def self.up
    add_column :page_sections, :class_name, :string
  end

  def self.down
    remove_column :page_sections, :class_name
  end
end
