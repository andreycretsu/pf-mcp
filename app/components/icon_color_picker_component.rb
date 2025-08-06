class IconColorPickerComponent < ViewComponent::Base
  def initialize(selected_icon: nil, selected_color: nil, on_icon_selected: nil, on_color_selected: nil)
    @selected_icon = selected_icon
    @selected_color = selected_color
    @on_icon_selected = on_icon_selected
    @on_color_selected = on_color_selected
  end

  private

  attr_reader :selected_icon, :selected_color, :on_icon_selected, :on_color_selected

  def icon_categories
    [
      {
        name: "Common",
        icons: ["home", "user", "settings", "search", "heart", "star", "check", "plus", "minus", "edit", "delete", "download", "upload", "share", "link", "copy", "paste", "undo", "redo", "refresh", "close", "menu", "arrow-up", "arrow-down", "arrow-left", "arrow-right"]
      },
      {
        name: "Communication",
        icons: ["envelope", "phone", "message", "comment", "chat", "mail", "notification", "bell", "megaphone", "microphone", "video", "camera", "image", "file", "folder", "document", "attachment"]
      },
      {
        name: "Actions",
        icons: ["play", "pause", "stop", "forward", "backward", "skip", "record", "save", "print", "export", "import", "sync", "lock", "unlock", "key", "shield", "eye", "eye-slash", "filter", "sort"]
      }
    ]
  end

  def color_palette
    [
      { name: "neutral", value: "#6B7280", label: "Neutral" },
      { name: "primary", value: "#3B82F6", label: "Primary" },
      { name: "success", value: "#10B981", label: "Success" },
      { name: "warning", value: "#F59E0B", label: "Warning" },
      { name: "danger", value: "#EF4444", label: "Danger" },
      { name: "info", value: "#06B6D4", label: "Info" }
    ]
  end

  def selected_icon_class
    selected_icon ? "selected" : ""
  end

  def selected_color_class
    selected_color ? "selected" : ""
  end

  def selected_color_value
    return "#000000" unless selected_color
    
    color_palette.find { |c| c[:name] == selected_color }&.dig(:value) || "#000000"
  end
end 