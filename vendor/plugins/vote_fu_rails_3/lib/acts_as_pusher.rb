# ActsAsPusher
module PeteOnRails
  module Acts #:nodoc:
    module Pusher #:nodoc:

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def acts_as_pusher
          has_many :pushs, :as => :pusher, :dependent => :nullify  # If a voting entity is deleted, keep the pushs. 
          include PeteOnRails::Acts::Pusher::InstanceMethods
          extend  PeteOnRails::Acts::Pusher::SingletonMethods
        end
      end
      
      # This module contains class methods
      module SingletonMethods
      end
      
      # This module contains instance methods
      module InstanceMethods
        
        # Usage user.push_count(true)  # All +1 pushs
        #       user.push_count(false) # All -1 pushs
        #       user.push_count()      # All pushs
        
        def push_count(for_or_against = "all")
          where = (for_or_against == "all") ? 
            ["pusher_id = ? AND pusher_type = ?", id, self.class.name ] : 
            ["pusher_id = ? AND pusher_type = ? AND push = ?", id, self.class.name, for_or_against ]
                        
          Push.count(:all, :conditions => where)

        end
                
        def pushed_for?(pushable)
           0 < Push.count(:all, :conditions => [
                   "pusher_id = ? AND pusher_type = ? AND push = ? AND pushable_id = ? AND pushable_type = ?",
                   self.id, self.class.name, true, pushable.id, pushable.class.name
                   ])
         end

         def pushed_against?(pushable)
           0 < Push.count(:all, :conditions => [
                   "pusher_id = ? AND pusher_type = ? AND push = ? AND pushable_id = ? AND pushable_type = ?",
                   self.id, self.class.name, false, pushable.id, pushable.class.name
                   ])
         end

         def pushed_on?(pushable)
           0 < Push.count(:all, :conditions => [
                   "pusher_id = ? AND pusher_type = ? AND pushable_id = ? AND pushable_type = ?",
                   self.id, self.class.name, pushable.id, pushable.class.name
                   ])
         end
                
        def push_for(pushable)
          self.push(pushable, true)
        end
        
        def push_against(pushable)
          self.push(pushable, false)
        end

        def push(pushable, push)
          push = Push.new(:push => push, :pushable => pushable, :pusher => self)
          push.save
        end

      end
    end
  end
end
