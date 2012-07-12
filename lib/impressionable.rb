module Impressionable
  def is_impressionable
    has_many :impressions, :as=>:impressionable
    include InstanceMethods
  end
  module InstanceMethods
    def impression_count
      impressions.size
    end

    def unique_impression_count
      impressions.group(:ip_address).size
    end
  end
end

ActiveRecord::Base.extend Impressionable
