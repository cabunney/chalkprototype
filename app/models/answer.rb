class Answer < ActiveRecord::Base
	belongs_to	:user
	scope :descending, :order => "created_at DESC"
  
	belongs_to	:question
	has_many	:tags
	belongs_to	:category

  acts_as_voteable

end
