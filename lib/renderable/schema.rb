module Renderable
  
  module Schema
    def self.included( base )
      
      ActiveRecord::ConnectionAdapters::Table.send :include, TableDefinition
      ActiveRecord::ConnectionAdapters::TableDefinition.send :include, TableDefinition
      ActiveRecord::ConnectionAdapters::AbstractAdapter.send :include, Statements
      
    end
  end
  
  module Statements
    
    # Adds a renderable column to the specified table.
    #
    # This is reasonably intelligent, and will create any required fields. Thus, if you are adding renderable
    # functionality to an existing field, it will only add the ‘rendered’ version of the field.
    #
    # === Parameters
    #
    # [table_name]    the name of the table to which to add the field(s)
    # [field_name]    the base name of the field that will be added
    # [field_type]    the type of the field that will be added (defaults to @:string@)
    # [options]       any additional options to be passed to add_column
    #
    def add_renderable( table_name, field_name, field_type = :string, options = {})
      raise ArgumentError "Please specify name of table in add_renderable call in your migration" if table_name.blank?
      raise ArgumentError "Please specify name of field in add_renderable call in your migration" if field_name.blank?
      
      # do we have a suffix specified
      suffix = options.delete(:suffix) { |k| '_rendered' }
      
      # add base column
      add_column table_name, field_name, field_type, options unless column_exists?(table_name, field_name)

      # rendered column
      add_column table_name, "#{field_name}#{suffix}", field_type, options      
    end
    
    # Removes a renderable field from the specified table.
    #
    # === Parameters
    #
    # [table_name]    the name of the table from which to remove the field
    # [field_name]    the name of the field to remove
    # [suffix]        the custom suffix used when creating the field, if used at all
    #
    def remove_renderable( table_name, field_name, suffix = '_rendered' )
      
      remove_column table_name, field_name if column_exists?(table_name, field_name)
      remove_column table_name, "#{field_name}#{suffix}" if column_exists?(table_name, field_name)
      
    end
    
  end
  
  module TableDefinition
    
    # Adds a renderable field to the current table. This is used inside a create_table block.
    #
    # === Parameters
    #
    # [field_name]    the name of the field to add
    # [field_type]    the type of the field to add
    # [options]       any additional options to be passed to add_column
    #
    def renderable( field_name, field_type = :string, options = {} )
      raise ArgumentError "Please specify name of field in renderable call in your migration" if field_name.blank?
      
      # get suffix
      suffix = options.delete(:suffix) { |k| '_rendered' }
      
      # add columns
      column field_name, field_type, options
      column "#{field_name}#{suffix}", field_type, options
      
    end
  end
end