require 'renderable'
require 'renderable/schema'

module Renderable
  require 'rails'
  
  class Railtie < Rails::Railtie
    initializer 'renderable.insert_into_active_record' do |app|
      ActiveSupport.on_load :active_record do
        Renderable::Railtie.insert
      end
    end
  end
  
  class Railtie
    def self.insert
      if defined?(ActiveRecord)
        ActiveRecord::Base.send :include, Renderable::Glue
      end
    end
  end
end