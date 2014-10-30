module ControllerOwnershipMethods

  def delete_ownership
    cname = self.class.name.gsub("Controller", "").singularize
    item = eval("#{cname}.first(:conditions => {:id => #{params[:id].to_str.delete("^0-9")}})")
    if (item.user_id == current_user.id)
      user_id = params[:user_id].to_str.delete("^0-9")
      ac = {:action => "edit_ownership", :id => params[:id]}
    else
      user_id = current_user.id
      ac = {:action => "list_view"}
    end
    results = eval("#{cname}Ownership.first(:conditions => {:user_id => #{user_id}, :item_id => #{params[:id].to_str.delete("^0-9")}})")
    if results.blank?
      flash[:error] = "Błędne id, nie usunięto praw dostępu"
    else
      results.destroy
      flash[:notice] = "Usunięto prawa dostępu"
    end
    redirect_to ac
  end

  def edit_ownership
    main_class = eval("#{self.class.name.gsub("Controller", "").singularize}")
    own_class = eval("#{self.class.name.gsub("Controller", "").singularize}Ownership")
    @item = main_class.find_by_id(params[:id])
    ids = []
    own_class.find(:all, :conditions => {:item_id => params[:id]}).each{|ownership| ids << ownership.user_id}
    @users = User.find(:all, :conditions => {:id => ids})
    @teachers = User.find_all_by_role_id(Role.find_by_name("Wykładowca"))
    render "common/edit_ownership"
  end

  def add_ownership
    main_class = eval("#{self.class.name.gsub("Controller", "").singularize}")
    if (main_class.find(params[:id]).user_id != current_user.id)
      raise "Brak uprawnień. Prawa może edytować tylko właściciel"
    end
    if (params[:type] == "1")
      user = User.find(params[:user_id])
      if user.teacher?
        own_class = eval("#{self.class.name.gsub("Controller", "").singularize}Ownership")
        begin
          new_ownership = own_class.new({:item_id => params[:id], :user_id => params[:user_id]})
          new_ownership.save
          flash[:notice] = "Dodano uprawnienia"
        rescue
          flash[:error] = "Uprawnienia dla tego użytkownika już istnieją"
        end
      else
        flash[:error] = "Uprawnienia można nadawać tylko wykładowcom"
      end
    end
    if (params[:type] == "2")
      sub_class = nil
      if (self.class.name.gsub("Controller", "") == "Group")
        sub_class = User
        sub_own_class = UserOwnership
        t = 1
      end
      if (self.class.name.gsub("Controller", "") == "TestGroup")
        sub_class = Test
        sub_own_class = TestOwnership
        t = 2
      end
      if sub_class.nil?
        raise "Nie znaleziono klasy"
      else
        if (t == 1)
          items_group = sub_class.find(:all, :conditions => {:group_id => params[:id]})
        end
        if (t == 2)
          items_group= sub_class.find(:all,:conditions => {:test_group_id => params[:id]})
        end
        items_group.each do |sub_item|
          check_item = sub_own_class.find(:first, :conditions => {:item_id => sub_item.id, :user_id => params[:user_id]})
          if check_item.blank?
            if !sub_own_class.new({:item_id => sub_item.id, :user_id => params[:user_id]}).save
              raise "Nie udało się dodać praw dostępu dla elementu grupy"
            end
          end
        end
        flash[:notice] = "Dodano uprawnienia dla wszystkich elementów grupy"
      end
    end
  rescue Exception => e
    flash[:error] = e.message
  ensure
    redirect_to :action => "edit_ownership", :id => params[:id]
  end

end