module MCP
  class ComponentMerger
    def self.list_all
      # Combine components from both Rails and Vue
      rails_components = RailsDocsProvider.list_components
      vue_components = VueDocsProvider.list_components
      
      # Merge by component name (normalized to snake_case)
      all_components = (rails_components + vue_components).group_by { |c| normalize_name(c[:name]) }
      
      all_components.map do |name, items|
        frameworks = items.map { |i| i[:framework] }
        {
          name: name,
          frameworks: frameworks,
          rails_available: frameworks.include?('rails'),
          vue_available: frameworks.include?('vue'),
          display_name: items.first[:display_name] || name.humanize
        }
      end.sort_by { |c| c[:name] }
    end

    def self.get(component_name)
      normalized_name = normalize_name(component_name)
      
      {
        name: normalized_name,
        rails: RailsDocsProvider.get_component_docs(normalized_name),
        vue: VueDocsProvider.get_component_docs(normalized_name)
      }
    end

    def self.normalize_name(name)
      # Convert component names to snake_case for consistent lookup
      name.to_s.underscore.gsub(/[^a-z0-9_]/, '')
    end

    def self.component_exists?(component_name)
      normalized_name = normalize_name(component_name)
      RailsDocsProvider.component_exists?(normalized_name) || 
      VueDocsProvider.component_exists?(normalized_name)
    end
  end
end 