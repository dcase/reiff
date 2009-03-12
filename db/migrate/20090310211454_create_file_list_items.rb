class CreateFileListItems < ActiveRecord::Migration
  def self.up
    create_table :file_list_items do |t|
      t.string :description
      t.string :file_file_name
      t.string :file_content_type
      t.integer :file_file_size
      t.datetime :file_updated_at
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :file_list_items
  end
end
