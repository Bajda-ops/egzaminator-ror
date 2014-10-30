class RemoveAnswerIdFromTakenTests < ActiveRecord::Migration
  def self.up
    remove_column :taken_tests, :answer_id
  end

  def self.down
    add_column :taken_tests, :answer_id, :integer
  end
end
