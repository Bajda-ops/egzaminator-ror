module ControllerSviewMethods

  def s_list_view
    cname = self.class.name.gsub("Controller", "").singularize
    field = (cname == "Test") ? "name" : "surname"
    (cname == "Test") ? (@t = true; @u = false) : (@t = false; @u = true)
    @items = eval("#{cname}.find_all_with_user_rights(current_user.id, order=\"#{field} ASC\")")
    render "common/s_list_view"
  end

  def delete_with_content
      main_class = eval("#{self.class.name.gsub("Controller", "").singularize}")
      own_class = eval("#{self.class.name.gsub("Controller", "").singularize}Ownership")
      main_class.find(params[:id]).destroy
      Ownership.destroy_all({:user_id => params[:id]})
      own_class.destroy_all(:item_id => params[:id])
      flash[:notice] = "Poprawnie usunięto obiekt"
      redirect_to :action => "s_list_view"
  end

  def add
    main_class = eval("#{self.class.name.gsub("Controller", "").singularize}")
    @item = main_class.new
    self.prepare_coll
  end

  def save
    main_class = eval("#{self.class.name.gsub("Controller", "").singularize}")
    @item = main_class.new(params[:item])
    @item.user_id = current_user.id
    if self.check_errors(@item.save, @item)
      if (main_class.name == "User")
        (current_user.admin?) ? (@item.roles = ([] << Role.find_by_name(params[:role]))) : (@item.roles = ([] << Role.find_by_name("Student")))
      end
      redirect_to :action => 's_list_view'
    else
      self.prepare_coll
      render :action => 'add'
    end
  end

  def prepare_coll
    cname = self.class.name.gsub("Controller", "").singularize
    if cname == "Test"
      @groups = TestGroup.find_all_with_user_rights(current_user.id, "name ASC")
    else
      @groups = Group.find_all_with_user_rights(current_user.id, "name ASC")
    end
    if current_user.admin?
      @roles = Role.find(:all, :order => "name ASC")
    else
      @roles = nil
    end
  end

end