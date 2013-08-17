module Renderable
  module InstanceMethods
    
    private
      def renderable_render
      
        # 1. render everything
        suff = renderable_options[:suffix]
        renderable_options[:fields].each do |field|
                    
          content = self[field.to_sym]          
          self["#{field}#{suff}".to_sym] = content.nil? ? nil : RedCloth.new(content).to_html
          
        end
        
        # 2. trigger callbacks
        run_callbacks(:render)
      
      end
    
  end
end