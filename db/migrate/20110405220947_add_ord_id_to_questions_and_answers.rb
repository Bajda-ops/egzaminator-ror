class AddOrdIdToQuestionsAndAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :ord_id, :integer
    add_column :questions, :ord_id, :integer
  end

  def self.down
    remove_column :answers, :ord_id
    remove_column :questions, :ord_id
  end
end
