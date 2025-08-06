module MCP
  class TokensController < ApplicationController
    def index
      tokens = TokenProvider.list_all
      render json: {
        tokens: tokens,
        total: tokens.length,
        categories: tokens.map { |t| t[:category] }.uniq
      }
    end

    def show
      token_name = params[:name]
      token_docs = TokenProvider.get_token_docs(token_name)
      
      if token_docs
        render json: token_docs
      else
        render json: { 
          error: "Token not found",
          token_name: token_name,
          available_tokens: TokenProvider.list_all.map { |t| t[:name] }
        }, status: :not_found
      end
    end
  end
end 