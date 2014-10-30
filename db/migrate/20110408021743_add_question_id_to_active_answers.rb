class AddQuestionIdToActiveAnswers < ActiveRecord::Migration
  def self.up
    add_column :active_answers, :question_id, :integer
  end

  def self.down
    remove_column :active_answers, :question_id
  end
end
