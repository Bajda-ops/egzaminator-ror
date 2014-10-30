class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string  :name, :limit => 50, :null => false
      t.integer :year_nr, :null =>false
      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
