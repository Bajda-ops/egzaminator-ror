module ModelSviewMethods

  def self.included(base)
    base.extend ClassMethods
  end

  def full_name
    if self.respond_to?(:surname)
      return (self.name + " " + self.surname)
    else
      return self.name
    end
  end

  module ClassMethods

    def find_all_with_user_rights(user_id, order="id ASC")
      ids = []
      eval("#{self.name}.find_all_by_user_id(#{user_id}).each { |tg|  ids << tg.id }")
      eval("#{self.name}Ownership.find_all_by_user_id(#{user_id}).each { |tgo|  ids << tgo.item_id }")
      return eval("#{self.name}.find(ids.uniq, :order => order)")
    rescue
      return []
    end

  end
end