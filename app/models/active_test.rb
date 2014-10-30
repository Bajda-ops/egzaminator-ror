class ActiveTest < ActiveRecord::Base
  belongs_to :user
  belongs_to :test
  belongs_to :group
  has_many :active_answers, :dependent => :destroy
  has_many :participants, :dependent => :destroy

  def full_description
    return (self.test.name + " Grupa: " + self.test.test_group.name)
  end

  #Zakańcza wszystkie testy, którym minął czas działania lub aktywny test o podanym active_test_id
  def self.save_finished_tests(active_test_id=nil)
    if active_test_id.nil?
      active_tests = ActiveTest.find(:all).delete_if{|a_test| (a_test.start_time + a_test.test.duration.minutes) < Time.now}
    else
      active_tests = [] << ActiveTest.find(active_test_id)
    end
    active_tests.each do |a_test|
      @new_taken_test = TakenTest.new({:owner_id => a_test.user_id, :test_id => a_test.test_id, :group_id => a_test.group_id})
      if @new_taken_test.save
        a_test.active_answers.each do |a_answer|
          @new_taken_answer = TakenAnswer.new({:answer_id => a_answer.answer_id, :user_id => a_answer.user_id, :taken_test_id => @new_taken_test.id})
          if !@new_taken_answer.save
            raise "Nie udało się zapisać odpowiedzi do zakończonych"
          end
        end
        Participant.find_all_by_active_test_id(a_test.id).each do |participant|
          @new_taken_test.user << User.find(participant.user_id)
        end
        a_test.destroy
      else
        raise "Nie udało się zapisać zakończonego testu"
      end
    end
  end

  #Znajduje pytanie po ord_id
  def find_question_by_ord_id(ord_id)
    return self.test.questions.select{|q| q.ord_id.to_s == ord_id.to_s}.first
  end

  #Znajduje aktywne testy dla użytkownika
  def self.find_active_tests_for_user(user, order="id ASC")
    @active_tests = ActiveTest.find(:all, :conditions =>{:group_id => user.group_id, :is_running => false, :start_time => nil}).delete_if do |a_test|  
      !((a_test.user_id == user.user_id) or (!UserOwnership.find(:all, :conditions => {:user_id => a_test.user_id, :item_id => user.id}).blank?))
    end
    return @active_tests
  end

  #sprawdza, czy test jest uruchomiony
  def is_running?
    if (self.is_running and !start_time.nil?)
      return true
    else
      return false
    end
  end

end
