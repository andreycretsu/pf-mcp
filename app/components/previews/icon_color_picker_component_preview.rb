class IconColorPickerComponentPreview < ViewComponent::Preview
  # @!group Basic Examples
  
  # @label Default
  # @description Default icon color picker with no selections
  def default
    render IconColorPickerComponent.new
  end

  # @label With Selected Icon
  # @description Icon color picker with a pre-selected icon
  def with_selected_icon
    render IconColorPickerComponent.new(selected_icon: "star")
  end

  # @label With Selected Color
  # @description Icon color picker with a pre-selected color
  def with_selected_color
    render IconColorPickerComponent.new(selected_color: "primary")
  end

  # @label With Both Selected
  # @description Icon color picker with both icon and color selected
  def with_both_selected
    render IconColorPickerComponent.new(
      selected_icon: "heart",
      selected_color: "danger"
    )
  end

  # @!endgroup

  # @!group Interactive Examples
  
  # @label Common Icons
  # @description Shows common icons like home, user, settings
  def common_icons
    render IconColorPickerComponent.new(selected_icon: "home")
  end

  # @label Communication Icons
  # @description Shows communication icons like envelope, phone, message
  def communication_icons
    render IconColorPickerComponent.new(selected_icon: "envelope")
  end

  # @label Action Icons
  # @description Shows action icons like play, pause, save
  def action_icons
    render IconColorPickerComponent.new(selected_icon: "play")
  end

  # @!endgroup

  # @!group Color Examples
  
  # @label Primary Color
  # @description Shows primary blue color selection
  def primary_color
    render IconColorPickerComponent.new(
      selected_icon: "star",
      selected_color: "primary"
    )
  end

  # @label Success Color
  # @description Shows success green color selection
  def success_color
    render IconColorPickerComponent.new(
      selected_icon: "check",
      selected_color: "success"
    )
  end

  # @label Danger Color
  # @description Shows danger red color selection
  def danger_color
    render IconColorPickerComponent.new(
      selected_icon: "heart",
      selected_color: "danger"
    )
  end

  # @!endgroup
end 