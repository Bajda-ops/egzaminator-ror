class CreateTestGroups < ActiveRecord::Migration
  def self.up
    create_table :test_groups do |t|
      t.string  :name, :limit => 50, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :test_groups
  end
end
