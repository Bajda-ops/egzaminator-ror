class TestController < ApplicationController

  include ControllerOwnershipMethods
  include ControllerSviewMethods

  layout :choose_layout
  before_filter :login_required

  def choose_layout
    if ["show_question"].include?(action_name.to_str)
      return 'user_layout'
    else
      return 'admin_layout'
    end
  end

  #=============================================================================
  #=============================================================================
  #==================== USER METHODS ==========================================+
  #=============================================================================
  #=============================================================================


  #@todo dodać render elementów na stronie
  def skip_to_q
    self.show_q_params
    render :action => 'show_question', :active_test_id => params[:active_test_id], :question_ord_id => params[:question_ord_id]
  end

  def next_q
    q_max = ActiveTest.find(params[:active_test_id]).test.questions.size
    redirect_to :action =>'show_question', :active_test_id => params[:active_test_id], :question_ord_id => ((Integer(params[:question_ord_id]) == q_max) ? 1 : (Integer(params[:question_ord_id]) + 1))
  end

  def prev_q
    q_max = ActiveTest.find(params[:active_test_id]).test.questions.size
    redirect_to :action =>'show_question', :active_test_id => params[:active_test_id], :question_ord_id => ((Integer(params[:question_ord_id]) == 1) ? q_max : (Integer(params[:question_ord_id]) - 1))
  end

  def show_q_params
    @current_active_test = ActiveTest.find(params[:active_test_id])
    @current_test = @current_active_test.test
    if params[:question_ord_id].nil?
      @current_question = @current_test.questions("ord_id ASC").first
    else
      @current_question = @current_active_test.find_question_by_ord_id(params[:question_ord_id])
    end
    @q_ords = []
    @current_test.questions.size.times{|i| @q_ords << [i+1, i+1]}
  end

  def show_question
    self.show_q_params
  end

  def mark_answer
    if !params[:answer].nil?
      params[:question_ord_id].nil? ? ( params[:question_ord_id] = 1) : nil
      question_id = ActiveTest.find(params[:active_test_id]).find_question_by_ord_id(params[:question_ord_id]).id
      ActiveAnswer.destroy_all({:user_id => current_user.id, :active_test_id => params[:active_test_id], :question_id => question_id})
      params[:answer].each do |ans_id|
        ActiveAnswer.new({:user_id => current_user.id, :active_test_id => params[:active_test_id], :answer_id => ans_id, :question_id => question_id}).save
      end
    end
  rescue
    flash[:error] = "Wystąpił błąd przy zapisywaniu odpowiedzi"
  ensure
    redirect_to :action => 'show_question', :active_test_id => params[:active_test_id], :question_ord_id => params[:question_ord_id]
  end

  #=============================================================================
  #=============================================================================
  #==================== ADMIN METHODS ==========================================
  #=============================================================================
  #=============================================================================

  def fast_finish
    ActiveTest.save_finished_tests(params[:id])
  rescue => e
    flash[:error] = e.message
  ensure
    redirect_to :action => 'make_test'
  end

  def rss_playlist
    @videos = FileInfo.find_all_by_test_id_and_ext(params[:id], "video/x-flv", :order => "id ASC")
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end

  def make_test
    @tests = Test.find_all_with_user_rights(current_user.id, "name ASC")
    @groups = Group.find_all_with_user_rights(current_user.id, "name ASC")
    @a_tests = ActiveTest.find(:all, :conditions => {:user_id => current_user.id, :is_running => false}, :order => "created_at ASC")
    @ar_tests = ActiveTest.find(:all, :conditions => {:user_id => current_user.id, :is_running => true}, :order => "created_at ASC")
  end

  def start_test
    @a_test = ActiveTest.new({:test_id => params[:test_id], :user_id => current_user.id, :group_id => params[:group_id]})
    self.check_errors(@a_test.save, @a_test)
    redirect_to :action => 'make_test'
  end

  def activate_test
    @a_test = ActiveTest.find(params[:id])
    @a_test.update_attributes({:is_running => true, :start_time => DateTime.now})
    @a_test.test.randomize_questions
  rescue
    flash[:error] = "Nie udało się uruchomić testu"
  ensure
    redirect_to :action => 'make_test'
  end

  def destroy_a_test
    ActiveTest.find(params[:id]).destroy
  rescue
    flash[:error] = "Nie udało się usunąć aktywnego testu"
  ensure
    redirect_to :action => 'make_test'
  end

  def edit
    @test = Test.find(params[:id])
    @questions = Question.find_all_by_test_id(params[:id], :order => "id ASC")
    @question_types = QuestionType.find(:all)
  end

  def add_question
    @question = Question.new(:test_id => params[:id], :tekst => "---", :question_type_id => QuestionType.first.id)
    self.check_errors(@question.save, @question)
    redirect_to :action => 'edit', :id => params[:id]
  end

  def add_answer
    Answer.create :question_id => params[:question_id], :tekst => "---", :points => 0
    redirect_to :action => 'edit', :id => params[:test_id]
  end

  def change_question
    if params[:commit] == "Usuń załącznik"
      Question.find(params[:question_id]).file_info.destroy
      flash[:notice] = "Pomyślnie wykonano operację"
    end
    if params[:commit] == "Usuń pytanie"
      Question.find(params[:question_id]).destroy
      flash[:notice] = "Pomyślnie wykonano operację"
    end
    if params[:commit] == "Zapisz pytanie"
      @q = Question.find(params[:question_id])
      if self.check_errors(@q.update_attributes(params[:questions].first.last), @q)
        if !params[:attachment].nil?
          if @q.file_info.blank?
            tmp = FileInfo.create_from_upload(params)
            if tmp != true
              self.check_errors(false, tmp)
            end
          else
            #FileInfo.update_from_upload(params)
          end
        end
      end
    end
    redirect_to :action => 'edit', :id => params[:test_id]
  end


  def change_answer
    if params[:commit] == "Usuń załącznik"
      Answer.find(params[:answer_id]).file_info.destroy
      flash[:notice] = "Pomyślnie wykonano operację"
    end
    if params[:commit] == "Usuń odpowiedź"
      Answer.find(params[:answer_id]).destroy
      flash[:notice] = "Pomyślnie wykonano operację"
    end
    if params[:commit] == "Zapisz odpowiedź"
      @a = Answer.find(params[:answer_id])
      if self.check_errors(@a.update_attributes(params[:curr_answers].first.last), @a)
        if !params[:attachment].nil?
          if @a.file_info.blank?
            tmp = FileInfo.create_from_upload(params)
            if tmp != true
              self.check_errors(false, tmp)
            end
          else
            #FileInfo.update_from_upload(params)
          end
        end
      end
    end
    redirect_to :action => 'edit', :id => params[:test_id]
  end


  def delete_test
    Test.find(params[:id]).destroy
    flash[:notice] = "Usunięto wybrany test"
    redirect_to :action => 'list_view'
  end

  def create_test
    @test = Test.new
    @users = User.find(:all)
    @test_groups = TestGroup.find(:all,:order => "name ASC")
  end

  def save_test
    @test = Test.new(params[:test])
    if self.check_errors(@test.save, @test)
      redirect_to :action => 'test', :id => @test.id
    else
      @users = User.find(:all)
      render :action => 'create_test'
    end
  end
end
