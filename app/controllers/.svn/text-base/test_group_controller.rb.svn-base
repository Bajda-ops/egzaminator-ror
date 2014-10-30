class TestGroupController < ApplicationController

  include ControllerOwnershipMethods
  include ControllerViewMethods
  
  layout 'admin_layout'
  before_filter :login_required

  def list_ownerships

  end

  def save_test_group
    @test_group = TestGroup.new(params[:test_group])
    @test_group.user_id = current_user.id
    if self.check_errors(@test_group.save, @test_group)
      redirect_to :action => 'list_test_group'
    else
      render :action => 'add_test_group'
    end
  end
end
