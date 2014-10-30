class AddStartTimeAndIsRunningToActiveTests < ActiveRecord::Migration
  def self.up
    add_column :active_tests, :start_time, :timestamp
    add_column :active_tests, :is_running, :bool, :default => false
  end

  def self.down
    remove_column :active_tests, :start_time
    remove_column :active_tests, :is_running
  end
end
