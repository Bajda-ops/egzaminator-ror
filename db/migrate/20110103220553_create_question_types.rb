class CreateQuestionTypes < ActiveRecord::Migration
  def self.up
    create_table :question_types do |t|
      t.string :name, :null => false
      t.timestamps
    end
    add_column :questions, :question_type_id, :integer
  end

  def self.down
    drop_table :question_types
    remove_column :questions, :question_type_id
  end
end
