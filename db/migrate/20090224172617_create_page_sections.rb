class CreatePageSections < ActiveRecord::Migration
  def self.up
    create_table :page_sections do |t|
      t.string :title
      t.integer :position
      t.references :page
      t.references :content, :polymorphic => true
      t.boolean :has_scroll
      t.integer :scroll_width
      t.integer :scroll_height

      t.timestamps
    end
  end

  def self.down
    drop_table :page_sections
  end
end
