class TakenAnswer < ActiveRecord::Base
  belongs_to :answer
  belongs_to :user
  belongs_to :taken_test
end
