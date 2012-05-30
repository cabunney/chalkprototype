class Question < ActiveRecord::Base
	belongs_to	:user
	scope :descending, :order => "created_at DESC"
  
	has_many	  :answers
	belongs_to	:user
	has_many	  :tags
	belongs_to	:category

  validates :user_id, presence: true
	validates :title, presence: true, length: { maximum: 37 }, :allow_blank => false, uniqueness: { case_sensitive: false }
	validates :description, presence: true, :allow_blank => false
	validates :category, presence: true
	
	acts_as_voteable
	acts_as_pushable
	
	self.per_page = 10
end
