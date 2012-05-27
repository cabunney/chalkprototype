class Push < ActiveRecord::Base

  scope :for_pusher,    lambda { |*args| {:conditions => ["pusher_id = ? AND pusher_type = ?", args.first.id, args.first.class.name]} }
  scope :for_pushable, lambda { |*args| {:conditions => ["pushable_id = ? AND pushable_type = ?", args.first.id, args.first.class.name]} }
  scope :recent,       lambda { |*args| {:conditions => ["created_at > ?", (args.first || 2.weeks.ago).to_s(:db)]} }
  scope :descending, :order => "created_at DESC"

  # NOTE: Votes belong to the "pushable" interface, and also to pushers
  belongs_to :pushable, :polymorphic => true
  belongs_to :pusher,    :polymorphic => true
  
  attr_accessible :push, :pusher, :pushable

  # Uncomment this to limit users to a single vote on each item. 
  validates_uniqueness_of :pushable_id, :scope => [:pushable_type, :pusher_type, :pusher_id]

end