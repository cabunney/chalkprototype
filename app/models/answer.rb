class Answer < ActiveRecord::Base
	belongs_to	:user
	scope :descending, :order => "created_at DESC"
  
	belongs_to	:question
	has_and_belongs_to_many	:tags
	belongs_to	:category

  validates :user_id, presence: true
  validates :question_id, presence: true
	validates :description, presence: true

  acts_as_voteable

end
