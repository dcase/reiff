class CreateAbstractLists < ActiveRecord::Migration
  def self.up
    create_table :abstract_lists do |t|
      t.string :name
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :abstract_lists
  end
end
