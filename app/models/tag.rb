class Tag < ActiveRecord::Base
	has_and_belongs_to_many	:question
	has_and_belongs_to_many	:answer
	belongs_to :user
end
