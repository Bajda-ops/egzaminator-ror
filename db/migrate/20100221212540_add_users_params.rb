class AddUsersParams < ActiveRecord::Migration
  def self.up
     add_column :users, :name, :string, :default => "---"
     add_column :users, :surname, :string, :default => "---"
     add_column :users, :index_nr, :integer, :default => 0
     add_column :users, :group_id, :integer
  end

  def self.down
    remove_column :users, :name
    remove_column :users, :surname
    remove_column :users, :index_nr
    remove_column :users, :group_id
  end
end
