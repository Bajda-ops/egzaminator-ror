class ActiveTestController < ApplicationController

  layout 'user_layout'

  def participate
    @current_test = ActiveTest.find(params[:id])
    if Participant.find(:all,:conditions => {:user_id => current_user.id,:active_test_id => params[:id]}).blank?
      if !Participant.new({:user_id => current_user.id, :active_test_id => params[:id]}).save
        flash[:error] = "Nie udało się dołączyć do testu"
        redirect_to :controller => 'users', :action => 'list_tests_active'
      end
    else
      flash[:error] = "Już dołączyłeś do tego testu"
    end
  end

end
