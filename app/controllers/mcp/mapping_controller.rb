module MCP
  class MappingController < ApplicationController
    def figma_to_rails
      figma_data = params[:figma_data]
      
      if figma_data.blank?
        render json: { error: "Figma data is required" }, status: :bad_request
        return
      end

      result = FigmaToRailsMapper.map(figma_data)
      
      if result[:success]
        render json: result
      else
        render json: result, status: :unprocessable_entity
      end
    end

    def component_mapping
      component_name = params[:name]
      
      mapping = ComponentMappingService.get_mapping(component_name)
      
      if mapping
        render json: mapping
      else
        render json: { 
          error: "Component mapping not found",
          component_name: component_name,
          available_components: ComponentMerger.list_all.map { |c| c[:name] }
        }, status: :not_found
      end
    end
  end
end 