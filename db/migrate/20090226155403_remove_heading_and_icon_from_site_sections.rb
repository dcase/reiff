class RemoveHeadingAndIconFromSiteSections < ActiveRecord::Migration
  def self.up
    remove_column :site_sections, :heading_file_name
    remove_column :site_sections, :heading_content_type
    remove_column :site_sections, :heading_file_size
    remove_column :site_sections, :heading_updated_at
    remove_column :site_sections, :icon_file_name
    remove_column :site_sections, :icon_content_type
    remove_column :site_sections, :icon_file_size
    remove_column :site_sections, :icon_updated_at
  end

  def self.down
    add_column :site_sections, :heading_file_name, :string
    add_column :site_sections, :heading_content_type, :string
    add_column :site_sections, :heading_file_size, :integer
    add_column :site_sections, :heading_updated_at, :datetime
    add_column :site_sections, :icon_file_name, :string
    add_column :site_sections, :icon_content_type, :string
    add_column :site_sections, :icon_file_size, :integer
    add_column :site_sections, :icon_updated_at, :datetime
  end
end
