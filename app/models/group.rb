class Group < ActiveRecord::Base

  include ModelOwnershipMethods
  include ModelHumanClassName
  include DestroyOwnershipModelMethods

  has_many :users
  belongs_to :user

  validates_presence_of :name, :message => "nie może być pusta"
  validates_presence_of :year_nr, :message => "nie może być pusty"
  validates_length_of :name, :within => 3..25, :message => "musi mieć długość 3-25 znaków"
  validates_numericality_of :year_nr, :only_integer => true, :message => "nie jest w postaci liczby"
  validates_inclusion_of :year_nr, :in => 1000..3000, :message => "musi być w zakresie 1000-3000"

  attr_accessible :name, :year_nr

  HUMAN_ATTRIBUTES = {
    :name                => "Nazwa grupy",
    :year_nr                 => "Rocznik"
  }

  def self.human_attribute_name(attr)
    HUMAN_ATTRIBUTES[attr.to_sym] || super
  end

  def user_has_rights?(user)
    if (self.user_id == user.id) or (GroupOwnership.find(:all, :conditions =>{:group_id => self.id, :user_id => user.id}).size > 0)
      return true
    else
      return false
    end
  end
  def full_name
    return "#{self.name} Rok: #{self.year_nr}"
  end

end
