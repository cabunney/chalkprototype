class Question < ActiveRecord::Base
	has_many	  :answers
	belongs_to	:user
	has_many	  :tags
	belongs_to	:category
end
