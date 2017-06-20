require 'renderable/callbacks'
require 'renderable/glue'
require 'renderable/instance_methods'
require 'renderable/version'

require 'renderable/railtie' if defined?(Rails)

require 'RedCloth'

module Renderable

  module ClassMethods

    # Add auto-rendering behaviour to an ActiveRecord object. This will automatically set up accessors on both original
    # and rendered fields, using attr_accessor
    #
    # === Parameters
    #
    # [options] a Hash containing options for Renderable (see below)
    #
    # === Options
    #
    # [:fields]   an array of ActiveRecord fields you wish to make renderable
    # [:suffix]   the suffix to use for ‘rendered’ versions of fields. (default: ‘_rendered’)
    #
    def acts_as_renderable( options = {} )
      include InstanceMethods

      # sanity check
      if options[:fields].blank?
        return
      end

      # default options
      options[:suffix]        ||= '_rendered'
      options[:restrictions]  ||= []

      # store the options
      self.renderable_options = options

      # set accessible on fields
      options[:fields].each do |field|
        if ::Rails::VERSION::STRING < '4.0'
          attr_accessible field, "#{field}#{options[:suffix]}"
        end

        define_renderable_callbacks :"#{field}_render"
      end

      # set up callbacks
      define_renderable_callbacks :render

      # hook
      before_save :renderable_render

    end

  end

end
