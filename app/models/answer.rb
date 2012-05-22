class Answer < ActiveRecord::Base
	belongs_to	:question
	belongs_to	:user
	has_many	:tags
	belongs_to	:category

end
