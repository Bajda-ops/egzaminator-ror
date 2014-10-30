class AddGroupIdToTakenTests < ActiveRecord::Migration
  def self.up
    add_column :taken_tests, :group_id, :integer
  end

  def self.down
    remove_column :taken_tests, :group_id
  end
end
