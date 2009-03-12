class CreateListItems < ActiveRecord::Migration
  def self.up
    create_table :list_items do |t|
      t.text :output
      t.integer :position
      t.references :list

      t.timestamps
    end
  end

  def self.down
    drop_table :list_items
  end
end
