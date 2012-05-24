# ActsAsPushable
module Juixe
  module Acts #:nodoc:
    module Pushable #:nodoc:

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def acts_as_pushable
          has_many :pushes, :as => :pushable, :dependent => :nullify

          include Juixe::Acts::Pushable::InstanceMethods
          extend  Juixe::Acts::Pushable::SingletonMethods
        end        
      end
      
      # This module contains class methods
      module SingletonMethods
        
        # Calculate the push counts for all pushables of my type.
        def tally(options = {})
          find(:all, options_for_tally(options.merge({:order =>"count DESC" })))
        end

        # 
        # Options:
        #  :start_at    - Restrict the pushes to those created after a certain time
        #  :end_at      - Restrict the pushes to those created before a certain time
        #  :conditions  - A piece of SQL conditions to add to the query
        #  :limit       - The maximum number of pushables to return
        #  :order       - A piece of SQL to order by. Eg 'pushes.count desc' or 'pushable.created_at desc'
        #  :at_least    - Item must have at least X pushes
        #  :at_most     - Item may not have more than X pushes
        def options_for_tally (options = {})
            options.assert_valid_keys :start_at, :end_at, :conditions, :at_least, :at_most, :order, :limit

            scope = scope(:find)
            start_at = sanitize_sql(["#{Push.table_name}.created_at >= ?", options.delete(:start_at)]) if options[:start_at]
            end_at = sanitize_sql(["#{Push.table_name}.created_at <= ?", options.delete(:end_at)]) if options[:end_at]

            type_and_context = "#{Push.table_name}.pushable_type = #{quote_value(base_class.name)}"

            conditions = [
              type_and_context,
              options[:conditions],
              start_at,
              end_at
            ]

            conditions = conditions.compact.join(' AND ')
            conditions = merge_conditions(conditions, scope[:conditions]) if scope

            joins = ["LEFT OUTER JOIN #{Push.table_name} ON #{table_name}.#{primary_key} = #{Push.table_name}.pushable_id"]
            joins << scope[:joins] if scope && scope[:joins]
            at_least  = sanitize_sql(["COUNT(#{Push.table_name}.id) >= ?", options.delete(:at_least)]) if options[:at_least]
            at_most   = sanitize_sql(["COUNT(#{Push.table_name}.id) <= ?", options.delete(:at_most)]) if options[:at_most]
            having    = [at_least, at_most].compact.join(' AND ')
            group_by  = "#{Push.table_name}.pushable_id HAVING COUNT(#{Push.table_name}.id) > 0"
            group_by << " AND #{having}" unless having.blank?

            { :select     => "#{table_name}.*, COUNT(#{Push.table_name}.id) AS count", 
              :joins      => joins.join(" "),
              :conditions => conditions,
              :group      => group_by
            }.update(options)          
        end
      end
      
      # This module contains instance methods
      module InstanceMethods
        def pushes_for
          Push.count(:all, :conditions => [
            "pushable_id = ? AND pushable_type = ? AND push = ?",
            id, self.class.name, true
          ])
        end
        
        def pushes_against
          Push.count(:all, :conditions => [
            "pushable_id = ? AND pushable_type = ? AND push = ?",
            id, self.class.name, false
          ])
        end
        
        # Same as pushable.pushes.size
        def pushes_count
          self.pushes.size
        end
        
        def pushers_who_pushed
          pushers = []
          self.pushes.each { |v|
            pushers << v.pusher
          }
          pushers
        end
        
        def pushed_by?(pusher)
          rtn = false
          if pusher
            self.pushes.each { |v|
              rtn = true if (pusher.id == v.pusher_id && pusher.class.name == v.pusher_type)
            }
          end
          rtn
        end
        
        
      end
    end
  end
end
