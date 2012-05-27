class Question < ActiveRecord::Base
	belongs_to	:user
	scope :descending, :order => "created_at DESC"
  
	has_many	  :answers
	belongs_to	:user
	has_many	  :tags
	belongs_to	:category
	
	validates :title, presence: true
	validates :description, presence: true
	
	acts_as_voteable
	
end
