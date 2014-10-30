class CreateOwnerships < ActiveRecord::Migration
  def self.up
    create_table :ownerships do |t|
      t.integer :item_id, :null => false
      t.integer :user_id, :null => false
      t.string :type
    end
  end

  def self.down
    drop_table :ownerships
  end
end
