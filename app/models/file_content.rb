class FileContent < ActiveRecord::Base
  belongs_to :file_info

  validates_presence_of     :content, :message => "nie może być pusta"

   HUMAN_ATTRIBUTES = {
    :content               => "Zawartość pliku"
  }

  def self.human_attribute_name(attr)
    HUMAN_ATTRIBUTES[attr.to_sym] || super
  end
end
