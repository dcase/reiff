class CreateSiteSections < ActiveRecord::Migration
  def self.up
    create_table :site_sections do |t|
      t.string :name
      t.integer :parent_id
      t.string :heading_file_name
      t.string :heading_content_type
      t.integer :heading_file_size
      t.datetime :heading_updated_at
      t.string :icon_file_name
      t.string :icon_content_type
      t.integer :icon_file_size
      t.datetime :icon_updated_at
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :site_sections
  end
end
