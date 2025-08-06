# 🎨 Lookbook Design System

A beautiful, pixel-perfect Rails design system built with Lookbook, featuring components directly translated from Vue.js designs.

## ✨ Features

- **🎯 Pixel-Perfect Components** - Built to match Figma designs exactly
- **📚 Lookbook Integration** - Interactive component documentation
- **🔧 Rails 7.1 + ViewComponent** - Modern Rails development stack
- **🎨 FontAwesome Pro Icons** - Professional icon library
- **📱 Responsive Design** - Mobile-first approach
- **♿ Accessible** - WCAG compliant components

## 🚀 Components

### IconColorPicker

A comprehensive icon and color picker component featuring:

- **240+ FontAwesome Pro icons** organized by categories
- **Searchable icon grid** with smooth scrolling
- **Color palette** with predefined design system colors
- **Custom color input** with hex value support
- **Figma-accurate styling** with proper shadows and selection states

### ControlTile

Atomic control components with:

- **Multiple variants** (primary, secondary, success, warning, danger, outline)
- **Icon + control combinations** with mutual exclusivity
- **Hover and active states** matching design specifications
- **Clean, minimal API** for easy integration

## 🛠 Development

### Prerequisites

- Ruby 3.4.5+
- Rails 7.1+
- Node.js (for FontAwesome icons)

### Getting Started

```bash
# Install dependencies
bundle install

# Start the Rails server
rails server

# Visit Lookbook
open http://localhost:3000/lookbook
```

## 📁 Project Structure

```
app/
├── components/           # Rails ViewComponents
│   ├── icon_color_picker_component.rb
│   ├── icon_color_picker_component.html.erb
│   ├── control_tile_component.rb
│   ├── control_tile_component.html.erb
│   └── previews/         # Lookbook previews
│       ├── icon_color_picker_component_preview.rb
│       └── control_tile_component_preview.rb
└── controllers/
    └── home_controller.rb

config/
├── routes.rb            # Lookbook mounted at /lookbook
└── application.rb       # Rails 7.1 configuration
```

## 🎨 Design System

This library implements components from a comprehensive design system featuring:

- **Consistent Color Palette** - Neutrals, primary, and semantic colors
- **Typography Scale** - Inter font family with proper weights
- **Spacing System** - 4px grid-based spacing
- **Component States** - Hover, active, disabled, and selected states
- **Shadows & Effects** - Subtle elevation and depth

## 🔧 Usage

### IconColorPicker

```erb
<%= render IconColorPickerComponent.new(
  selected_icon: "star",
  selected_color: "primary"
) %>
```

### ControlTile

```erb
<%= render ControlTileComponent.new(
  variant: "primary",
  icon: "heart",
  label: "Favorite",
  size: "medium"
) %>
```

## 🌐 Integration with MCP Server

This design system is designed to work with the [MCP Design System Server](https://github.com/andreycretsu/mcp-design-system-server) for AI-powered code generation.

The MCP server provides:
- Component discovery and documentation
- Figma-to-Rails property mapping
- Automated code generation for feature developers

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-component`
3. Make your changes and add Lookbook previews
4. Test with Lookbook: `rails server` then visit `/lookbook`
5. Commit your changes: `git commit -m 'Add amazing component'`
6. Push to the branch: `git push origin feature/amazing-component`
7. Open a Pull Request

## 📄 License

MIT License - see LICENSE for details

## 🙏 Acknowledgments

- Built with Lookbook
- Icons by FontAwesome Pro
- Styled with love and attention to Figma details ❤️ 