class Answer < ActiveRecord::Base
	has_many	:questions
	belongs_to	:user
	has_many	:tags
	belongs_to	:category
end
