class Answer < ActiveRecord::Base
  belongs_to :question
  has_one :file_info, :dependent => :destroy

  validates_presence_of     :tekst, :message => "nie może być pusty"
  validates_presence_of     :points, :message => "nie mogą pozostać puste"
  validates_numericality_of :points, :message => "muszą być wyrażone liczbą"

  HUMAN_ATTRIBUTES = {
    :tekst                => "Tekst odpowiedzi",
    :points               => "Punkty"
  }

  def self.human_attribute_name(attr)
    HUMAN_ATTRIBUTES[attr.to_sym] || super
  end
 
  def choosen?(user_id, active_test_id)
    if ActiveAnswer.find(:all, :conditions => {:user_id => user_id, :active_test_id => active_test_id, :answer_id => self.id}).blank?
      return false
    else
      return true
    end
  end

end
