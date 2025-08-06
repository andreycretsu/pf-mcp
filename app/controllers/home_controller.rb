class HomeController < ApplicationController
  def index
    render json: {
      message: "Lookbook Design System",
      version: "1.0.0",
      lookbook_url: "/lookbook",
      components: [
        "IconColorPicker",
        "ControlTile"
      ],
      documentation: "This is a Rails design system with Lookbook, matching your Vue components"
    }
  end
end 