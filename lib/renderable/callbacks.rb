module Renderable
  module Callbacks
    def self.included(base)
      base.extend(Defining)
    end

    module Defining
      def define_renderable_callbacks(*callbacks)
        define_callbacks *[callbacks, {:terminator => callback_terminator}].flatten
        callbacks.each do |callback|
          eval <<-end_callbacks
            def before_#{callback}(*args, &blk)
              set_callback(:#{callback}, :before, *args, &blk)
            end
            def after_#{callback}(*args, &blk)
              set_callback(:#{callback}, :after, *args, &blk)
            end
          end_callbacks
        end
      end
      
      private
        def callback_terminator
          if ::ActiveSupport::VERSION::STRING >= '4.1'
            lambda { |target, result| result == false }
          else
            'result == false'
          end
        end
    end
  end
end
