class Question < ActiveRecord::Base
	has_many	  :answers
	belongs_to	:user
	has_many	  :tags
	belongs_to	:category
	
	validates :title, presence: true
	validates :description, presence: true
	
	
end
