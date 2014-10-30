module ModelOwnershipMethods

  def self.included(base)
    base.extend ClassMethods
  end

  def find_all_deps_with_user_rights(user_id, order="id ASC")
    ids = []
    case self.class.name
    when "Group" :
        dep_class_name = "User"
      dep_key = "group_id"
    when "TestGroup" :
        dep_class_name = "Test"
      dep_key = "test_group_id"
    end
    eval("#{dep_class_name}Ownership.find(:all, :conditions => {:user_id => #{user_id.to_s.delete("^0-9")}}).each {|ownership| ids << ownership.item_id}")
    return eval("#{dep_class_name}.find(:all, :conditions => {#{ids.blank? ? nil : ":id => ids,"}:#{dep_key} => self.id }, :order => order)")
  end

    
  module ClassMethods

    def find_all_with_user_rights(user_id, order="id ASC")
      ids = []
      eval("#{self.name}.find_all_by_user_id(#{user_id}).each { |tg|  ids << tg.id }")
      eval("#{self.name}Ownership.find_all_by_user_id(#{user_id}).each { |tgo|  ids << tgo.item_id }")
      return eval("#{self.name}.find(ids.uniq, :order => order)")
    end

  end

end