class CreateContactListItems < ActiveRecord::Migration
  def self.up
    create_table :contact_list_items do |t|
      t.string :name
      t.string :title
      t.string :email
      t.integer :position
      t.references :contact_list

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_list_items
  end
end
