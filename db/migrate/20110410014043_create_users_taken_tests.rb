class CreateUsersTakenTests < ActiveRecord::Migration
  def self.up
    create_table :taken_tests_users do |t|
      t.integer :user_id
      t.integer :taken_test_id
    end
  end

  def self.down
    drop_table :taken_tests_users
  end
end
