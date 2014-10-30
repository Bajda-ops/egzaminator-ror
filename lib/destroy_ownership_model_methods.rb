module DestroyOwnershipModelMethods
  def destroy
    own_class = eval("#{self.class.name}Ownership")
    own_class.destroy_all({:item_id => self.id})
    super
  end
end