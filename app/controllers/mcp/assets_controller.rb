module MCP
  class AssetsController < ApplicationController
    def index
      # List all available assets (icons, illustrations, etc.)
      assets = AssetProvider.list_all
      render json: {
        assets: assets,
        total: assets.length,
        categories: assets.map { |a| a[:category] }.uniq
      }
    end

    def show
      asset_name = params[:name]
      asset_docs = AssetProvider.get_asset_docs(asset_name)
      
      if asset_docs
        render json: asset_docs
      else
        render json: { 
          error: "Asset not found",
          asset_name: asset_name,
          available_assets: AssetProvider.list_all.map { |a| a[:name] }
        }, status: :not_found
      end
    end
  end
end 