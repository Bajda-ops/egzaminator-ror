class CreateFileInfos < ActiveRecord::Migration
  def self.up
    create_table :file_infos do |t|
      t.string  :name, :limit => 255, :null => false
      t.string  :ext, :limit => 255, :null => false
      t.integer :file_content_id
      t.timestamps
    end
  end

  def self.down
    drop_table :file_infos
  end
end
