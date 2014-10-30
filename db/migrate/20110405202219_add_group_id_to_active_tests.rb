class AddGroupIdToActiveTests < ActiveRecord::Migration
  def self.up
    add_column :active_tests, :group_id, :integer, :null => false
  end

  def self.down
    remove_column :active_tests, :group_id
  end
end
