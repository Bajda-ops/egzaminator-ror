class AttachmentsUpdate2 < ActiveRecord::Migration
  def self.up
    add_column :file_contents, :file_info_id, :integer, :default => nil
  end

  def self.down
    remove_column :file_contents, :file_info_id
  end
end
