module ControllerViewMethods

  def add
    @item = eval("#{self.class.name.gsub("Controller", "")}.new")
  end

  def save
    class_name = self.class.name.gsub("Controller", "")
    class_ref = eval("#{class_name}")
    @item = class_ref.new(params[:item])
    @item.user_id = current_user.id
    if self.check_errors(@item.save, @item)
      redirect_to :action => 'list_view'
    else
      render :action => 'add'
    end
  end

  def edit
    @item = eval("#{self.class.name.gsub("Controller", "")}").find_by_id(params[:id])
  end

  def update
    class_name = self.class.name.gsub("Controller", "")
    @item = eval("#{class_name}").find(params[:id])
    if self.check_errors(@item.update_attributes(params[:item]), @item)
      render :action => 'edit', :id => @item.id
    else
      render :action => 'edit', :id => @item.id
    end
  end

  def list_view
    hi_class = eval("#{self.class.name.gsub("Controller","")}")
    if current_user.admin?
      @hi_items = hi_class.find(:all, :order => "id ASC")
    else
      @hi_items = hi_class.find_all_with_user_rights(current_user.id, "name ASC")
    end
    if self.class.name.gsub("Controller","") == "Group"
      @g = true
      @tg = false
    else
      @g = false
      @tg = true
    end
    render "common/list_view"
  end

  def delete_with_content
    main_class = eval("#{self.class.name.gsub("Controller", "").singularize}")
    own_class = eval("#{self.class.name.gsub("Controller", "").singularize}Ownership")
    main_class.find(params[:id]).destroy
    Ownership.destroy_all({:user_id => params[:id]})
    own_class.destroy_all(:item_id => params[:id])
    flash[:notice] = "Usunięto wybraną grupę"
    redirect_to :action => 'list_view'
  end

end