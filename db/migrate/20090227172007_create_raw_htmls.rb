class CreateRawHtmls < ActiveRecord::Migration
  def self.up
    create_table :raw_htmls do |t|
      t.text :output

      t.timestamps
    end
  end

  def self.down
    drop_table :raw_htmls
  end
end
