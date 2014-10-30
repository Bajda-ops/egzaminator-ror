class ResultController < ApplicationController

  layout 'admin_layout', :except => [:generate_pdf]

  def show
    @types = [['Użytkownik', 1], ['Grupa', 2]]
    @groups = Group.find_all_with_user_rights(current_user.id, "name ASC")
    @users = User.find_all_with_user_rights(current_user.id, "surname ASC")
  end

  def generate_pdf
    if params[:taken_test_id].blank?
      raise "Nie wybrano testu lub błędne ID"
    else
      @t_test = TakenTest.find_by_id(params[:taken_test_id])
    end
    if @t_test.nil?
      raise "Nie znaleziono testu o podanym ID"
    else
      case params[:ctype]
      when "1" then
        @pdf_file = @t_test.generate_pdf_results('User', params[:item_id])
        type_name = "grupy"
      when "2" then
        @pdf_file = @t_test.generate_pdf_results('Group', params[:item_id])
        type_name = "użytkownika"
      else
        raise "Błędny typ generowanego pliku pdf"
      end
      #@todo jakis sensowny tytuł
      filename = "Wyniki.pdf"
      send_data(@pdf_file.render, :type => 'application/pdf', :filename => filename, :disposition => 'inline')
    end
  rescue Exception => e
    flash[:error] = e.message
    redirect_to :controller => 'result', :action => 'show'
  end

  def reload_elements_tests
    case params[:ctype]
    when "1" then
      @items = User.find_all_with_user_rights(current_user.id, "surname ASC")
      render :partial => "result/elements", :locals => {:ctype => params[:ctype], :citems => @items}
    when "2" then
      @items = Group.find_all_with_user_rights(current_user.id, "name ASC")
      render :partial => "result/elements", :locals => {:ctype => params[:ctype], :citems => @items}
    else
      render :partial => "result/elements"
    end
  end

  def reload_tests
    case params[:ctype]
    when "1" then
      @items = TakenTest.find(:all).delete_if { |t_test| !t_test.user.include?(User.find(params[:element_id])) }
      render :partial => "result/tests", :locals => {:ctype => params[:ctype], :citems => @items}
    when "2" then
      @items = TakenTest.find(:all, :conditions => {:group_id => params[:element_id]}, :order => "id ASC")
      render :partial => "result/tests", :locals => {:ctype => params[:ctype], :citems => @items}
    else
      render :partial => "result/tests"
    end
  end

end
