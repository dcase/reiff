class RemoveNameFromAbstractLists < ActiveRecord::Migration
  def self.up
    remove_column :abstract_lists, :name
  end

  def self.down
    add_column :abstract_lists, :name, :string
  end
end
