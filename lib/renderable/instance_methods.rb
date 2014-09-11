module Renderable
  module InstanceMethods
    
    private
      def renderable_render
                
        suff = renderable_options[:suffix]
        renderable_options[:fields].each do |field|
          
          # skip if the field is unchanged
          next unless self.changed.include? field.to_s

          # actually render
          run_callbacks(:render) do            
            run_callbacks(:"#{field}_render") do           
                            
              # a. call out          
              content = self[field.to_sym]          
              content = content.nil? ? nil : RedCloth.new(content, renderable_options[:restrictions]).to_html
          
              # b. if we're using RedCloth's lite_mode, let's make the HTML sane again...
              if renderable_options[:restrictions].include?(:lite_mode)
            
                # for reasons best known to RedCloth, lite_mode replaces all newlines with a BR tag. This is butt-ugly and
                # we can do better.
                #
                # So, let's find all instances of multiple BRs and replace them with Ps.
                content = '<p>'+content.gsub( /(<br\s?\/?>\n){2,}/, "</p>\n\n<p>" )+'</p>';
            
              end
          
              # c. copy it back
              self["#{field}#{suff}".to_sym] = content
            end
          end  
          
        end
      
      end
    
  end
end