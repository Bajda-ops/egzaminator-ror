class QuestionType < ActiveRecord::Base
  has_many :questions

  validates_presence_of     :name, :message => "nie może być pusta"
  validates_length_of       :name,    :within => 3..40, :message => "nie jest odpowiedniej długości (3-40)"

  HUMAN_ATTRIBUTES = {
    :name                => "Nazwa typu pytania"
  }

  def self.human_attribute_name(attr)
    HUMAN_ATTRIBUTES[attr.to_sym] || super
  end

end
