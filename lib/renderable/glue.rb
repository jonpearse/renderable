require 'renderable/schema'

module Renderable
  module Glue
    def self.included base
      base.extend ClassMethods
      base.send :include, Callbacks
      base.send :include, Schema if defined? ActiveRecord

      base.class_attribute :renderable_options
    end
  end
end
