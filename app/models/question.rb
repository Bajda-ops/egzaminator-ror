class Question < ActiveRecord::Base
  has_many :answers, :dependent => :destroy
  belongs_to :test
  belongs_to :question_type
  has_one :file_info, :dependent => :destroy

  validates_presence_of     :tekst, :message => "nie może być pusty"

  HUMAN_ATTRIBUTES = {
    :tekst                => "Tekst pytania"
  }

  def self.human_attribute_name(attr)
    HUMAN_ATTRIBUTES[attr.to_sym] || super
  end

  def answers(order="id ASC")
    answers = Answer.find_all_by_question_id(self.id, :order => order)
    return answers
  end

  def randomize_answers
    orders = []
    qs = self.answers.size
    qs.times{|i| orders << i + 1}
    qs.times do |i|
      tmp_index_1 = rand(qs)
      tmp_index_2 = rand(qs)
      tmp_item = orders[tmp_index_1]
      orders[tmp_index_1] = orders[tmp_index_2]
      orders[tmp_index_2] = tmp_item
    end
    self.answers.each_with_index do |item,index|
      item.update_attribute(:ord_id, orders[index])
    end
  end


end
