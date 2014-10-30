class Test < ActiveRecord::Base

  include ModelHumanClassName
  include ModelSviewMethods
  include DestroyOwnershipModelMethods

  has_many :taken_tests, :dependent => :destroy
  has_many :questions, :dependent => :destroy
  has_many :file_infos, :dependent =>:destroy
  belongs_to :user
  belongs_to :test_group

  validates_presence_of     :name, :message => "nie może być pusta"
  validates_presence_of     :user_id, :message => "nie może być pusty"
  validates_presence_of     :test_group_id, :message => "nie może być pusta"
  validates_length_of       :name,    :within => 3..40, :message => "nie jest odpowiedniej długości (3-40)"
  validates_numericality_of :duration, :message => "nie jest w postaci liczby"
  validates_inclusion_of    :duration, :in => 1..500, :message => "musi być w zakresie 1-500"

  HUMAN_ATTRIBUTES = {
    :name                => "Nazwa testu",
    :user_id             => "Identyfikator właściciela",
    :test_group_id       => "Grupa testów",
    :duration            => "Czas trwania"
  }

  def self.human_attribute_name(attr)
    HUMAN_ATTRIBUTES[attr.to_sym] || super
  end

  def full_description
    return (self.name + " Grupa: " + self.test_group.name)
  end

  def questions(order="id ASC")
    questions = Question.find_all_by_test_id(self.id, :order => order)
    return questions
  end

  def randomize_questions
    orders = []
    qs = self.questions.size
    qs.times{|i| orders << i + 1}
    qs.times do |i|
      tmp_index_1 = rand(qs)
      tmp_index_2 = rand(qs)
      tmp_item = orders[tmp_index_1]
      orders[tmp_index_1] = orders[tmp_index_2]
      orders[tmp_index_2] = tmp_item
    end
    self.questions.each_with_index do |item,index|
      item.update_attribute(:ord_id, orders[index])
      item.randomize_answers
    end
  end

end
