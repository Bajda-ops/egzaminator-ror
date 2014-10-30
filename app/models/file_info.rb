class FileInfo < ActiveRecord::Base
  has_one :file_content, :dependent => :destroy
  belongs_to :question
  belongs_to :answer
  belongs_to :test

  FILE_TYPES = ["audio/mpeg", "video/x-flv", "image/jpeg", "image/gif" ]

  validates_presence_of :name, :message => "nie może być pusta"
  validates_presence_of :ext,:message => "nie może być puste"
  validates_presence_of :test_id,:message => "nie może być puste"
  validates_inclusion_of :ext, :in => FILE_TYPES, :message => "nie jest na liście obsługiwanych formatów plików (jpg, jpeg, gif, mp3, flv)"
  validates_length_of :name, :within => 3..40, :message => "musi mieć długość 3-40 znaków"
  validates_length_of :name, :within => 3..25, :message => "musi mieć długość 3-25 znaków"

  HUMAN_ATTRIBUTES = {
    :name                => "Nazwa załącznika",
    :ext                 => "Rozszerzenie",
    :test_id             => "Id testu"
  }

  def self.human_attribute_name(attr)
    HUMAN_ATTRIBUTES[attr.to_sym] || super
  end

  def self.create_from_upload(params)
    @new_fi = FileInfo.new
    if !params[:question_id].nil?
      @new_fi.name = "question_#{params[:question_id]}"
      @new_fi.owner_type = "q"
      @new_fi.question_id = params[:question_id]
    else
      @new_fi.name = "answer_#{params[:answer_id]}"
      @new_fi.owner_type = "a"
      @new_fi.answer_id = params[:answer_id]
    end
    @new_fi.ext = params[:attachment].content_type
    @new_fi.test_id = params[:test_id]
    if @new_fi.save
      @new_f = FileContent.new
      @new_f.content = params[:attachment].read
      @new_f.file_info_id = @new_fi.id
      if @new_f.save
        @new_fi.update_attribute(:file_content_id, @new_f.id)
        return true
      else
        @new_fi.destroy
        return @new_f
      end
    else
      return @new_fi
    end
  end

  def self.update_from_upload(params)
    
  end

end
