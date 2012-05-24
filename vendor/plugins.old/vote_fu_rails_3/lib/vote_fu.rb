require 'acts_as_voteable'
require 'acts_as_voter'
require 'acts_as_pushable'
require 'acts_as_pusher'
require 'has_karma'
require 'models/vote.rb'
require 'models/push.rb'

ActiveRecord::Base.send(:include, Juixe::Acts::Voteable)
ActiveRecord::Base.send(:include, PeteOnRails::Acts::Voter)
ActiveRecord::Base.send(:include, Juixe::Acts::Pushable)
ActiveRecord::Base.send(:include, PeteOnRails::Acts::Pusher)
ActiveRecord::Base.send(:include, PeteOnRails::VoteFu::Karma)
RAILS_DEFAULT_LOGGER.info "** vote_fu: initialized properly."
