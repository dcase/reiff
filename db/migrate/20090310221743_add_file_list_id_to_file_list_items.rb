class AddFileListIdToFileListItems < ActiveRecord::Migration
  def self.up
    add_column :file_list_items, :file_list_id, :integer
  end

  def self.down
    remove_column :file_list_items, :file_list_id
  end
end
