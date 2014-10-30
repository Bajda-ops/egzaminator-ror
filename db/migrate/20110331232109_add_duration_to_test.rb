class AddDurationToTest < ActiveRecord::Migration
  def self.up
    add_column :tests, :duration, :integer, :null => false
  end

  def self.down
    remove_column :tests, :duration
  end
end
