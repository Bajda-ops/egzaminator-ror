class AttachmentsUpdate < ActiveRecord::Migration
  def self.up
    add_column :file_infos, :owner_type, :string, :default => nil
    add_column :file_infos, :question_id, :integer, :default => nil
    add_column :file_infos, :answer_id, :integer, :default => nil
  end

  def self.down
    remove_column :file_infos, :owner_type
    remove_column :file_infos, :question_id
    remove_column :file_infos, :answer_id
  end
end
