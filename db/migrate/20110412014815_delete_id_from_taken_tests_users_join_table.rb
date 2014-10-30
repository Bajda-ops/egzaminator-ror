class DeleteIdFromTakenTestsUsersJoinTable < ActiveRecord::Migration
  def self.up
    remove_column :taken_tests_users, :id
  end

  def self.down
    add_column :taken_tests_users, :id, :integer
  end
end
