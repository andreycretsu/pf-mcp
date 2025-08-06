module MCP
  class ComponentMappingService
    def self.get_mapping(component_name)
      normalized_name = ComponentMerger.normalize_name(component_name)
      rails_docs = RailsDocsProvider.get_component_docs(normalized_name)
      vue_docs = VueDocsProvider.get_component_docs(normalized_name)
      
      return nil if rails_docs.nil? && vue_docs.nil?
      
      {
        component_name: normalized_name,
        rails: rails_docs ? {
          class_name: rails_docs[:class_name],
          props: rails_docs[:props],
          figma_mapping: rails_docs[:figma_mapping],
          usage_examples: rails_docs[:usage_examples]
        } : nil,
        vue: vue_docs ? {
          component_name: vue_docs[:component_name],
          props: vue_docs[:props],
          figma_mapping: vue_docs[:figma_mapping],
          usage_examples: vue_docs[:usage_examples]
        } : nil,
        cross_framework_mapping: generate_cross_framework_mapping(rails_docs, vue_docs)
      }
    end

    def self.generate_cross_framework_mapping(rails_docs, vue_docs)
      return {} if rails_docs.nil? || vue_docs.nil?
      
      mapping = {}
      
      # Map Rails props to Vue props
      rails_docs[:props]&.each do |rails_prop|
        vue_prop = find_matching_vue_prop(rails_prop, vue_docs[:props])
        if vue_prop
          mapping[rails_prop[:name]] = {
            rails: rails_prop,
            vue: vue_prop,
            conversion_notes: generate_conversion_notes(rails_prop, vue_prop)
          }
        end
      end
      
      mapping
    end

    def self.find_matching_vue_prop(rails_prop, vue_props)
      return nil unless vue_props
      
      # Try exact name match first
      vue_props.find { |vp| vp[:name] == rails_prop[:name] } ||
      # Try camelCase conversion
      vue_props.find { |vp| vp[:name] == rails_prop[:name].camelize(:lower) } ||
      # Try other common patterns
      vue_props.find { |vp| vp[:name].underscore == rails_prop[:name] }
    end

    def self.generate_conversion_notes(rails_prop, vue_prop)
      notes = []
      
      # Type differences
      if rails_prop[:type] != vue_prop[:type]
        notes << "Type conversion: Rails #{rails_prop[:type]} → Vue #{vue_prop[:type]}"
      end
      
      # Default value differences
      if rails_prop[:default] != vue_prop[:default]
        notes << "Default value: Rails #{rails_prop[:default]} → Vue #{vue_prop[:default]}"
      end
      
      # Required differences
      if rails_prop[:required] != vue_prop[:required]
        notes << "Required: Rails #{rails_prop[:required]} → Vue #{vue_prop[:required]}"
      end
      
      notes
    end

    def self.get_figma_mapping_rules(component_name)
      mapping = get_mapping(component_name)
      return {} unless mapping
      
      {
        figma_to_rails: mapping[:rails]&.dig(:figma_mapping) || {},
        figma_to_vue: mapping[:vue]&.dig(:figma_mapping) || {},
        component_name: component_name
      }
    end
  end
end 