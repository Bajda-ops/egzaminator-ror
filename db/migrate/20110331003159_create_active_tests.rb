class CreateActiveTests < ActiveRecord::Migration
  def self.up
    create_table :active_tests do |t|
      t.column :test_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :active_tests
  end
end
