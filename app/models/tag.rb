class Tag < ActiveRecord::Base
	has_and_belongs_to_many	:questions
	has_and_belongs_to_many	:answers
	belongs_to :user
end
