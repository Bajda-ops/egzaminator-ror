class RepairTakenTestUserRelationViaOwnerId < ActiveRecord::Migration
  def self.up
    remove_column :taken_tests, :user_id
    add_column :taken_tests, :owner_id, :integer
  end

  def self.down
    remove_column :taken_tests, :owner_id
    add_column :taken_tests, :user_id, :integer
  end
end
