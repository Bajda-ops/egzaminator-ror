class UsersController < ApplicationController
  
  include ControllerOwnershipMethods
  include ControllerSviewMethods
  # Be sure to include AuthenticationSystem in Application Controller instead
  layout :choose_layout
  #  before_filter :login_required
  #require_role "Wykładowca"
  #  require_role

  def choose_layout
    if ["start", "info", "list_tests_results", "list_tests_active"].include?(action_name.to_str)
      return 'user_layout'
    else
      return 'admin_layout'
    end
  end

  def start

  end

  def info
   
  end

  def list_tests_results
   
  end

  def list_tests_active
    @active_tests = ActiveTest.find_active_tests_for_user(current_user)
  end

  def import_export_data

  end

  def edit
    @user = User.find(params[:id])
    self.prepare_coll
  end

  def update_user
    @user = User.find(params[:id])
    self.prepare_coll
    if @user.update_attributes(params[:user])
      (current_user.admin?) ? (@user.roles = ([] << Role.find_by_name(params[:role]))) : (@user.roles = ([] << Role.find_by_name("Student")))
      flash[:notice] = "Zaktualizowano dane użytkownika"
      render :action => 'edit', :id => params[:id]
    else
      flash[:error] = "Nie udało się zaktualizować danych użytkownika"
      render :action => 'edit', :id => params[:id]
    end
  end

  def delete_user
    @user = User.find(params[:id])
    if ((@user.user_id == current_user.id) or (current_user.admin?))
      User.find(params[:id]).destroy
      flash[:notice] = "Usunięto wybranego użytkownika"
      redirect_to :action => 'list_users'
    else
      flash[:error] = "Brak uprawnień do usunięcia użytkownika"
      redirect_to :action => 'list_users'
    end
  end

  def add_user
    @user = User.new
    @groups = Group.find(:all, :order => "name ASC")
    (current_user.admin?) ? (@roles = Role.find(:all, :order => "name ASC")) : (@roles = nil)
    
  end

  # render new.rhtml
  def new
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default('/')
      flash[:notice] = "Użytkownik zarejestrowany"
    else
      render :action => 'new'
    end
  end

end
