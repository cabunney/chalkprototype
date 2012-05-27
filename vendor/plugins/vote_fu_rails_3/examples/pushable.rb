class Pushable < ActiveRecord::Base

  belongs_to :user
  
  acts_as_pushable

  scope :descending, :order => "created_at DESC"

  
end