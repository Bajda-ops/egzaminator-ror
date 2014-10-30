class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.integer :active_test_id, :null => false
      t.integer :user_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :participants
  end
end
