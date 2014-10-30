class CreateFileContents < ActiveRecord::Migration
  def self.up
    create_table :file_contents do |t|
      t.binary :content, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :file_contents
  end
end
