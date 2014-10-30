class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.integer :test_id
      t.text    :tekst, :null => false
      t.integer :file_info_id
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
