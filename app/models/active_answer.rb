class ActiveAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :answer
  belongs_to :active_test
  belongs_to :question
end
