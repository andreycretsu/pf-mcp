class ControlTileComponentPreview < ViewComponent::Preview
  # @!group Basic Examples
  
  # @label Default
  # @description Default control tile with primary variant
  def default
    render ControlTileComponent.new(label: "Click me")
  end

  # @label With Icon
  # @description Control tile with icon and label
  def with_icon
    render ControlTileComponent.new(
      icon: "star",
      label: "Favorite"
    )
  end

  # @label Icon Only
  # @description Control tile with icon only
  def icon_only
    render ControlTileComponent.new(icon: "heart")
  end

  # @!endgroup

  # @!group Variants
  
  # @label Primary
  # @description Primary blue variant
  def primary
    render ControlTileComponent.new(
      variant: "primary",
      label: "Primary Action"
    )
  end

  # @label Secondary
  # @description Secondary gray variant
  def secondary
    render ControlTileComponent.new(
      variant: "secondary",
      label: "Secondary Action"
    )
  end

  # @label Success
  # @description Success green variant
  def success
    render ControlTileComponent.new(
      variant: "success",
      icon: "check",
      label: "Success"
    )
  end

  # @label Warning
  # @description Warning orange variant
  def warning
    render ControlTileComponent.new(
      variant: "warning",
      icon: "exclamation-triangle",
      label: "Warning"
    )
  end

  # @label Danger
  # @description Danger red variant
  def danger
    render ControlTileComponent.new(
      variant: "danger",
      icon: "trash",
      label: "Delete"
    )
  end

  # @label Outline
  # @description Outline variant with border
  def outline
    render ControlTileComponent.new(
      variant: "outline",
      label: "Outline Button"
    )
  end

  # @!endgroup

  # @!group States
  
  # @label Active
  # @description Active state with focus ring
  def active
    render ControlTileComponent.new(
      label: "Active Button",
      active: true
    )
  end

  # @label Disabled
  # @description Disabled state
  def disabled
    render ControlTileComponent.new(
      label: "Disabled Button",
      disabled: true
    )
  end

  # @!endgroup

  # @!group Sizes
  
  # @label Small
  # @description Small size variant
  def small
    render ControlTileComponent.new(
      size: "small",
      label: "Small Button"
    )
  end

  # @label Medium
  # @description Medium size variant (default)
  def medium
    render ControlTileComponent.new(
      size: "medium",
      label: "Medium Button"
    )
  end

  # @label Large
  # @description Large size variant
  def large
    render ControlTileComponent.new(
      size: "large",
      label: "Large Button"
    )
  end

  # @!endgroup

  # @!group Interactive Examples
  
  # @label Play Controls
  # @description Example of play control buttons
  def play_controls
    content_tag :div, class: "play-controls-example" do
      safe_join([
        render(ControlTileComponent.new(icon: "play", label: "Play")),
        render(ControlTileComponent.new(icon: "pause", label: "Pause")),
        render(ControlTileComponent.new(icon: "stop", label: "Stop"))
      ])
    end
  end

  # @label Navigation Controls
  # @description Example of navigation control buttons
  def navigation_controls
    content_tag :div, class: "navigation-controls-example" do
      safe_join([
        render(ControlTileComponent.new(icon: "arrow-left", label: "Previous")),
        render(ControlTileComponent.new(icon: "home", label: "Home")),
        render(ControlTileComponent.new(icon: "arrow-right", label: "Next"))
      ])
    end
  end

  # @!endgroup
end 