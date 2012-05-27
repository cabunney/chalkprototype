
require 'acts_as_pushable'
require 'acts_as_pusher'
require 'models/push.rb'

ActiveRecord::Base.send(:include, Juixe::Acts::Pushable)
ActiveRecord::Base.send(:include, PeteOnRails::Acts::Pusher)
