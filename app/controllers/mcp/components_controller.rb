module MCP
  class ComponentsController < ApplicationController
    def index
      # List all available components from both Rails and Vue
      components = ComponentMerger.list_all
      render json: {
        components: components,
        total: components.length,
        frameworks: ['rails', 'vue']
      }
    end

    def show
      component_name = params[:name]
      docs = ComponentMerger.get(component_name)
      
      if docs[:rails].nil? && docs[:vue].nil?
        render json: { 
          error: "Component not found", 
          component_name: component_name,
          available_components: ComponentMerger.list_all.map { |c| c[:name] }
        }, status: :not_found
      else
        render json: {
          name: component_name,
          rails: docs[:rails],
          vue: docs[:vue],
          mapping_rules: get_mapping_rules(component_name)
        }
      end
    end

    private

    def get_mapping_rules(component_name)
      # Return mapping rules for Figma properties to component props
      case component_name
      when 'badge'
        {
          figma_to_rails: {
            'Size' => { 'L 24px' => 'size: "large"', 'M 16px' => 'size: "medium"', 'S 12px' => 'size: "small"' },
            'Emphasis' => { 'High' => 'emphasized: true', 'Low' => 'emphasized: false' },
            'Color' => { 'Grey' => 'color: "neutral"', 'Blue' => 'color: "primary"', 'Red' => 'color: "danger"' },
            'Icon' => { 'true' => 'icon: "icon_name"', 'false' => nil },
            'Label' => { 'text' => 'text: "text_value"' }
          },
          figma_to_vue: {
            'Size' => { 'L 24px' => 'size="large"', 'M 16px' => 'size="medium"', 'S 12px' => 'size="small"' },
            'Emphasis' => { 'High' => 'emphasized', 'Low' => nil },
            'Color' => { 'Grey' => 'color="neutral"', 'Blue' => 'color="primary"', 'Red' => 'color="danger"' },
            'Icon' => { 'true' => 'icon="icon_name"', 'false' => nil },
            'Label' => { 'text' => 'inner text content' }
          }
        }
      else
        {}
      end
    end
  end
end 