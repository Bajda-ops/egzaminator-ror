class CreateActiveAnswers < ActiveRecord::Migration
  def self.up
    create_table :active_answers do |t|
      t.integer :user_id
      t.integer :answer_id
      t.integer :active_test_id
      t.timestamps
    end
  end

  def self.down
    drop_table :active_answers
  end
end
