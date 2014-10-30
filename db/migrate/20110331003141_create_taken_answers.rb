class CreateTakenAnswers < ActiveRecord::Migration
  def self.up
    create_table :taken_answers do |t|
      t.column :answer_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
      t.column :taken_test_id, :integer, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :taken_answers
  end
end
