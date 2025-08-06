# 🚀 MCP Design System Server

A Model Context Protocol (MCP) server that bridges your Rails + Vue design system with AI tools, implementing Typeform's Iteration 2 approach for design-to-code workflows.

## Overview

This MCP server provides on-demand access to your design system components, enabling AI tools (like Cursor, Claude Code) to generate accurate Rails code from Figma designs without consuming the entire context window.

## Architecture

### Components
- **Rails ViewComponents** → Documented in Lookbook
- **Vue Components** → Documented in Storybook  
- **Design Tokens** → Colors, spacing, typography
- **Assets** → Icons, illustrations

### MCP Endpoints

Following Typeform's approach, the server exposes these tool calls:

- `list-components` → `GET /mcp/components`
- `get-component-docs` → `GET /mcp/components/:name`
- `list-assets` → `GET /mcp/assets`
- `get-asset-docs` → `GET /mcp/assets/:name`
- `list-tokens` → `GET /mcp/tokens`
- `get-token-docs` → `GET /mcp/tokens/:name`
- `map-figma-to-rails` → `POST /mcp/map-figma-to-rails`

## Setup

1. **Install dependencies:**
   ```bash
   bundle install
   ```

2. **Start the server:**
   ```bash
   rails server
   ```

3. **Access the API:**
   - Root: `http://localhost:3000/`
   - Components: `http://localhost:3000/mcp/components`
   - Lookbook: `http://localhost:3000/lookbook`

## Usage Examples

### List All Components
```bash
curl http://localhost:3000/mcp/components
```

### Get Badge Component Documentation
```bash
curl http://localhost:3000/mcp/components/badge
```

### Map Figma to Rails
```bash
curl -X POST http://localhost:3000/mcp/map-figma-to-rails \
  -H "Content-Type: application/json" \
  -d '{
    "figma_data": {
      "componentName": "Badge",
      "properties": {
        "Size": "L 24px",
        "Emphasis": "High",
        "Color": "Grey",
        "Icon": "true",
        "Label": "Badge"
      },
      "icon": {
        "name": "star",
        "type": "solid"
      },
      "text": "Badge"
    }
  }'
```

## Figma to Rails Mapping

The server implements the mapping workflow from your example:

**Figma Properties** → **Rails Component Props**
- `Size: L 24px` → `size: "large"`
- `Emphasis: High` → `emphasized: true`
- `Color: Grey` → `color: "neutral"`
- `Icon: star` → `icon: "star"`
- `Label: Badge` → `text: "Badge"`

**Generated Rails Code:**
```ruby
render Vue::BadgeComponent.new(
  text: "Badge",
  size: "large",
  color: "neutral",
  icon: "star",
  icon_type: "solid",
  emphasized: true
)
```

## Integration with AI Tools

### Cursor/Claude Code Configuration
Add this to your AI tool's MCP configuration:

```json
{
  "mcpServers": {
    "design-system": {
      "command": "rails",
      "args": ["server"],
      "env": {
        "RAILS_ENV": "development"
      }
    }
  }
}
```

### Workflow
1. **AI reads Figma design** via Figma MCP
2. **AI queries design system** via this MCP server
3. **AI generates Rails code** using component documentation
4. **Feature developers** use generated code in their Rails views

## Customization

### Adding New Components
1. Add component data to `RailsDocsProvider` or `VueDocsProvider`
2. Update mapping rules in the respective provider
3. Test with the API endpoints

### Updating Mapping Rules
Edit the `figma_mapping` hashes in the component providers to match your Figma property names and values.

## Benefits

- **Reduced Context Usage**: Only loads needed component docs (30-40% vs 70%)
- **Accurate Code Generation**: Uses your actual component APIs
- **Framework Consistency**: Maintains Rails/Vue component alignment
- **Design System Compliance**: Ensures generated code follows your patterns

## Next Steps

1. **Integrate with Lookbook API** for dynamic Rails component discovery
2. **Connect to Vue Storybook API** for real-time Vue component data
3. **Add more component mappings** as you build out your design system
4. **Implement caching** for better performance
5. **Add authentication** if needed for production use

## Contributing

This is a foundation that you can extend based on your specific needs. The modular design makes it easy to add new components, mapping rules, and integrations. 