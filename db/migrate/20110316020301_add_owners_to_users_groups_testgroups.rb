class AddOwnersToUsersGroupsTestgroups < ActiveRecord::Migration
  def self.up
    add_column :users, :user_id, :integer
    add_column :groups, :user_id, :integer
    add_column :test_groups, :user_id, :integer
  end

  def self.down
    remove_column :users, :user_id
    remove_column :groups, :user_id
    remove_column :test_groups, :user_id
  end
end
