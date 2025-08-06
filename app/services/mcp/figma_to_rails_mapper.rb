module MCP
  class FigmaToRailsMapper
    def self.map(figma_data)
      begin
        component_name = extract_component_name(figma_data)
        component_docs = ComponentMerger.get(component_name)
        
        if component_docs[:rails].nil?
          return {
            success: false,
            error: "Rails component not found",
            component_name: component_name,
            available_components: ComponentMerger.list_all.map { |c| c[:name] }
          }
        end

        rails_props = map_figma_properties_to_rails(figma_data, component_docs[:rails])
        rails_code = generate_rails_code(component_docs[:rails], rails_props)
        
        {
          success: true,
          component_name: component_name,
          figma_data: figma_data,
          rails_props: rails_props,
          rails_code: rails_code,
          mapping_explanation: generate_mapping_explanation(figma_data, rails_props)
        }
      rescue => e
        {
          success: false,
          error: "Mapping failed: #{e.message}",
          component_name: component_name
        }
      end
    end

    private

    def self.extract_component_name(figma_data)
      # Extract component name from Figma data
      # This would be based on your Figma component naming convention
      figma_data['componentName']&.downcase&.gsub(/[^a-z0-9_]/, '') || 'unknown'
    end

    def self.map_figma_properties_to_rails(figma_data, rails_docs)
      props = {}
      mapping_rules = rails_docs[:figma_mapping] || {}

      figma_data['properties']&.each do |property_name, property_value|
        if mapping_rules[property_name]
          mapped_value = mapping_rules[property_name][property_value.to_s]
          if mapped_value
            # Extract the prop name and value from the mapping
            if mapped_value.include?(':')
              prop_name, prop_value = mapped_value.split(': ', 2)
              props[prop_name.strip] = prop_value.strip.gsub('"', '')
            else
              props[property_name.underscore] = mapped_value
            end
          end
        end
      end

      # Handle special cases
      handle_special_properties(figma_data, props)
      
      props
    end

    def self.handle_special_properties(figma_data, props)
      # Handle text content
      if figma_data['text']
        props['text'] = figma_data['text']
      end

      # Handle icon properties
      if figma_data['icon'] && figma_data['icon']['name']
        props['icon'] = figma_data['icon']['name']
        props['icon_type'] = figma_data['icon']['type'] || 'solid'
      end

      # Handle size mapping
      if figma_data['size']
        size_mapping = { 'L 24px' => 'large', 'M 16px' => 'medium', 'S 12px' => 'small' }
        props['size'] = size_mapping[figma_data['size']] if size_mapping[figma_data['size']]
      end

      # Handle emphasis mapping
      if figma_data['emphasis']
        emphasis_mapping = { 'High' => true, 'Low' => false }
        props['emphasized'] = emphasis_mapping[figma_data['emphasis']] if emphasis_mapping[figma_data['emphasis']]
      end
    end

    def self.generate_rails_code(rails_docs, props)
      class_name = rails_docs[:class_name]
      
      if props.empty?
        "render #{class_name}.new"
      else
        props_string = props.map { |k, v| "#{k}: #{format_value(v)}" }.join(', ')
        "render #{class_name}.new(#{props_string})"
      end
    end

    def self.format_value(value)
      case value
      when String
        "\"#{value}\""
      when TrueClass, FalseClass
        value.to_s
      when Numeric
        value.to_s
      else
        "\"#{value}\""
      end
    end

    def self.generate_mapping_explanation(figma_data, rails_props)
      explanations = []
      
      figma_data['properties']&.each do |property_name, property_value|
        if rails_props[property_name.underscore]
          explanations << "Figma's \"#{property_name}: #{property_value}\" maps to #{property_name.underscore}: #{rails_props[property_name.underscore]}"
        end
      end

      explanations.join("\n")
    end
  end
end 