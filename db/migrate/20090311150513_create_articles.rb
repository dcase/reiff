class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :page_file_name
      t.string :page_content_type
      t.integer :page_file_size
      t.datetime :page_updated_at
      t.integer :position
      t.references :article_list_item

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
