class AddUniqIndexToOwnerships < ActiveRecord::Migration
  def self.up
    add_index  :ownerships, [:user_id, :item_id, :type], :unique => true
  end

  def self.down
  end
end
