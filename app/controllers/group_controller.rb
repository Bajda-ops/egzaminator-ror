class GroupController < ApplicationController
  
  include ControllerOwnershipMethods
  include ControllerViewMethods

  layout 'admin_layout'
  before_filter :login_required

end
