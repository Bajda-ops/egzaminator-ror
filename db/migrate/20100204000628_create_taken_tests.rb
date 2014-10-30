class CreateTakenTests < ActiveRecord::Migration
  def self.up
    create_table :taken_tests do |t|
      t.integer :answer_id
      t.integer :user_id
      t.integer :test_id
      t.timestamps
    end
  end

  def self.down
    drop_table :taken_tests
  end
end
