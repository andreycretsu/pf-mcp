class ControlTileComponent < ViewComponent::Base
  def initialize(
    variant: "primary",
    icon: nil,
    label: nil,
    active: false,
    disabled: false,
    size: "medium",
    on_click: nil
  )
    @variant = variant
    @icon = icon
    @label = label
    @active = active
    @disabled = disabled
    @size = size
    @on_click = on_click
  end

  private

  attr_reader :variant, :icon, :label, :active, :disabled, :size, :on_click

  def css_classes
    classes = ["control-tile"]
    classes << "control-tile--#{variant}"
    classes << "control-tile--#{size}"
    classes << "control-tile--active" if active
    classes << "control-tile--disabled" if disabled
    classes.join(" ")
  end

  def icon_classes
    classes = ["control-tile__icon"]
    classes << "fas"
    classes << "fa-#{icon}" if icon
    classes.join(" ")
  end

  def label_classes
    classes = ["control-tile__label"]
    classes << "control-tile__label--with-icon" if icon
    classes.join(" ")
  end

  def size_styles
    case size
    when "small"
      "font-size: 12px; padding: 8px 12px;"
    when "large"
      "font-size: 16px; padding: 16px 24px;"
    else
      "font-size: 14px; padding: 12px 16px;"
    end
  end

  def variant_styles
    case variant
    when "primary"
      "background: #3b82f6; color: white;"
    when "secondary"
      "background: #6b7280; color: white;"
    when "success"
      "background: #10b981; color: white;"
    when "warning"
      "background: #f59e0b; color: white;"
    when "danger"
      "background: #ef4444; color: white;"
    when "outline"
      "background: transparent; color: #3b82f6; border: 1px solid #3b82f6;"
    else
      "background: #f3f4f6; color: #374151;"
    end
  end
end 