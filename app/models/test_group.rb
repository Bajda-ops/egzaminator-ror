class TestGroup < ActiveRecord::Base

  include ModelOwnershipMethods
  include ModelHumanClassName
  include DestroyOwnershipModelMethods

  has_many :tests, :dependent => :destroy
  belongs_to :user

  validates_presence_of     :name, :message => "nie może być pusta"
  validates_length_of       :name,    :within => 3..40, :message => "nie jest odpowiedniej długości (3-40)"

  attr_accessible :name

  HUMAN_ATTRIBUTES = {
    :name               => "Nazwa grupy testów"
  }

  def self.human_attribute_name(attr)
    HUMAN_ATTRIBUTES[attr.to_sym] || super
  end

end
