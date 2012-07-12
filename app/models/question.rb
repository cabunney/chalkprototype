class Question < ActiveRecord::Base
	belongs_to	:user
	scope :descending, :order => "created_at DESC"
  
	has_many	  :answers
	belongs_to	:user
	has_and_belongs_to_many	  :tags
	belongs_to	:category

  validates :user_id, presence: true

	validates :description, presence: true, :allow_blank => false

	
	acts_as_voteable
	acts_as_pushable
	
	is_impressionable :counter_cache => true
	
	self.per_page = 10
end
