#!/usr/bin/env ruby

require 'sinatra'
require 'json'
require 'erb'

# Simple test application to demonstrate the MCP Design System Server
class TestDesignSystemApp < Sinatra::Base
  set :port, 3000
  set :bind, '0.0.0.0'

  # Root endpoint
  get '/' do
    content_type :json
    {
      message: "MCP Design System Server (Test Version)",
      version: "1.0.0",
      endpoints: {
        components: "/mcp/components",
        component_docs: "/mcp/components/:name",
        assets: "/mcp/assets",
        tokens: "/mcp/tokens",
        figma_mapping: "/mcp/map-figma-to-rails"
      },
      documentation: "This is a test version of the MCP server for your Rails + Vue design system"
    }.to_json
  end

  # MCP Components endpoints
  get '/mcp/components' do
    content_type :json
    components = [
      {
        name: 'badge',
        frameworks: ['rails', 'vue'],
        rails_available: true,
        vue_available: true,
        display_name: 'Badge'
      },
      {
        name: 'button',
        frameworks: ['rails', 'vue'],
        rails_available: true,
        vue_available: true,
        display_name: 'Button'
      },
      {
        name: 'tab_bar_primary',
        frameworks: ['rails'],
        rails_available: true,
        vue_available: false,
        display_name: 'Tab Bar Primary'
      }
    ]
    
    {
      components: components,
      total: components.length,
      frameworks: ['rails', 'vue']
    }.to_json
  end

  get '/mcp/components/:name' do
    content_type :json
    component_name = params[:name]
    
    case component_name
    when 'badge'
      {
        name: 'badge',
        rails: {
          class_name: 'Vue::BadgeComponent',
          description: 'A badge component for displaying status, labels, or notifications',
          props: [
            { name: 'text', type: 'String', required: true, description: 'The text content of the badge' },
            { name: 'size', type: 'String', required: false, default: 'medium', options: ['small', 'medium', 'large'], description: 'Size of the badge' },
            { name: 'color', type: 'String', required: false, default: 'neutral', options: ['neutral', 'primary', 'danger'], description: 'Color variant of the badge' },
            { name: 'icon', type: 'String', required: false, description: 'Icon name to display' },
            { name: 'icon_type', type: 'String', required: false, default: 'solid', options: ['solid', 'regular'], description: 'Icon style' },
            { name: 'emphasized', type: 'Boolean', required: false, default: false, description: 'Whether the badge should be emphasized' }
          ],
          usage_examples: [
            {
              title: 'Basic Badge',
              description: 'Simple badge with text',
              code: 'render Vue::BadgeComponent.new(text: "New")'
            },
            {
              title: 'Badge with Icon',
              description: 'Badge with icon and emphasis',
              code: 'render Vue::BadgeComponent.new(text: "Badge", icon: "star", icon_type: "solid", emphasized: true)'
            }
          ],
          figma_mapping: {
            'Size' => { 'L 24px' => 'size: "large"', 'M 16px' => 'size: "medium"', 'S 12px' => 'size: "small"' },
            'Emphasis' => { 'High' => 'emphasized: true', 'Low' => 'emphasized: false' },
            'Color' => { 'Grey' => 'color: "neutral"', 'Blue' => 'color: "primary"', 'Red' => 'color: "danger"' },
            'Icon' => { 'true' => 'icon: "icon_name"', 'false' => nil },
            'Label' => { 'text' => 'text: "text_value"' }
          }
        },
        vue: {
          component_name: 'PfBadge',
          description: 'A badge component for displaying status, labels, or notifications',
          props: [
            { name: 'size', type: 'String', required: false, default: 'medium', options: ['small', 'medium', 'large'], description: 'Size of the badge' },
            { name: 'color', type: 'String', required: false, default: 'neutral', options: ['neutral', 'primary', 'danger'], description: 'Color variant of the badge' },
            { name: 'icon', type: 'String', required: false, description: 'Icon name to display' },
            { name: 'iconType', type: 'String', required: false, default: 'solid', options: ['solid', 'regular'], description: 'Icon style' },
            { name: 'emphasized', type: 'Boolean', required: false, default: false, description: 'Whether the badge should be emphasized' }
          ],
          usage_examples: [
            {
              title: 'Basic Badge',
              description: 'Simple badge with text',
              code: '<PfBadge>New</PfBadge>'
            },
            {
              title: 'Badge with Icon',
              description: 'Badge with icon and emphasis',
              code: '<PfBadge icon="star" iconType="solid" emphasized>Badge</PfBadge>'
            }
          ],
          figma_mapping: {
            'Size' => { 'L 24px' => 'size="large"', 'M 16px' => 'size="medium"', 'S 12px' => 'size="small"' },
            'Emphasis' => { 'High' => 'emphasized', 'Low' => nil },
            'Color' => { 'Grey' => 'color="neutral"', 'Blue' => 'color="primary"', 'Red' => 'color="danger"' },
            'Icon' => { 'true' => 'icon="icon_name"', 'false' => nil },
            'Label' => { 'text' => 'inner text content' }
          }
        },
        mapping_rules: {
          figma_to_rails: {
            'Size' => { 'L 24px' => 'size: "large"', 'M 16px' => 'size: "medium"', 'S 12px' => 'size: "small"' },
            'Emphasis' => { 'High' => 'emphasized: true', 'Low' => 'emphasized: false' },
            'Color' => { 'Grey' => 'color: "neutral"', 'Blue' => 'color: "primary"', 'Red' => 'color: "danger"' },
            'Icon' => { 'true' => 'icon: "icon_name"', 'false' => nil },
            'Label' => { 'text' => 'text: "text_value"' }
          }
        }
      }.to_json
    else
      status 404
      {
        error: "Component not found",
        component_name: component_name,
        available_components: ['badge', 'button', 'tab_bar_primary']
      }.to_json
    end
  end

  # MCP Assets endpoints
  get '/mcp/assets' do
    content_type :json
    assets = [
      {
        name: 'star',
        display_name: 'Star',
        category: 'icons',
        type: 'icon',
        available_styles: ['solid', 'regular'],
        available_sizes: ['16px', '24px', '32px'],
        usage_in_components: ['badge', 'button', 'card']
      },
      {
        name: 'check',
        display_name: 'Check',
        category: 'icons',
        type: 'icon',
        available_styles: ['solid', 'regular'],
        available_sizes: ['16px', '24px', '32px'],
        usage_in_components: ['badge', 'button', 'checkbox']
      }
    ]
    
    {
      assets: assets,
      total: assets.length,
      categories: assets.map { |a| a[:category] }.uniq
    }.to_json
  end

  get '/mcp/assets/:name' do
    content_type :json
    asset_name = params[:name]
    
    case asset_name
    when 'star'
      {
        name: 'star',
        display_name: 'Star',
        category: 'icons',
        description: 'Star icon for ratings, favorites, and highlights',
        usage_examples: [
          {
            title: 'In Badge Component',
            description: 'Using star icon in a badge',
            rails_code: 'render Vue::BadgeComponent.new(text: "Favorite", icon: "star", icon_type: "solid")',
            vue_code: '<PfBadge icon="star" iconType="solid">Favorite</PfBadge>'
          }
        ],
        figma_mapping: {
          'Icon Name' => 'star',
          'Icon Style' => { 'Solid' => 'solid', 'Regular' => 'regular' },
          'Icon Size' => { '16px' => '16px', '24px' => '24px', '32px' => '32px' }
        }
      }.to_json
    else
      status 404
      {
        error: "Asset not found",
        asset_name: asset_name,
        available_assets: ['star', 'check']
      }.to_json
    end
  end

  # MCP Tokens endpoints
  get '/mcp/tokens' do
    content_type :json
    tokens = [
      {
        name: 'neutral',
        display_name: 'Neutral',
        category: 'colors',
        type: 'color',
        value: '#6B7280',
        usage_in_components: ['badge', 'button', 'text']
      },
      {
        name: 'primary',
        display_name: 'Primary',
        category: 'colors',
        type: 'color',
        value: '#3B82F6',
        usage_in_components: ['badge', 'button', 'link']
      },
      {
        name: 'large',
        display_name: 'Large',
        category: 'sizes',
        type: 'size',
        value: '24px',
        usage_in_components: ['badge', 'button', 'avatar']
      }
    ]
    
    {
      tokens: tokens,
      total: tokens.length,
      categories: tokens.map { |t| t[:category] }.uniq
    }.to_json
  end

  get '/mcp/tokens/:name' do
    content_type :json
    token_name = params[:name]
    
    case token_name
    when 'neutral'
      {
        name: 'neutral',
        display_name: 'Neutral',
        category: 'colors',
        description: 'Neutral color for secondary elements',
        value: '#6B7280',
        usage_examples: [
          {
            title: 'In Badge Component',
            description: 'Using neutral color in a badge',
            rails_code: 'render Vue::BadgeComponent.new(text: "Draft", color: "neutral")',
            vue_code: '<PfBadge color="neutral">Draft</PfBadge>'
          }
        ],
        figma_mapping: {
          'Grey' => 'neutral',
          'Gray' => 'neutral'
        }
      }.to_json
    else
      status 404
      {
        error: "Token not found",
        token_name: token_name,
        available_tokens: ['neutral', 'primary', 'large']
      }.to_json
    end
  end

  # MCP Figma to Rails mapping
  post '/mcp/map-figma-to-rails' do
    content_type :json
    
    begin
      figma_data = JSON.parse(request.body.read)['figma_data']
      
      if figma_data.nil?
        status 400
        return { error: "Figma data is required" }.to_json
      end

      # Extract component name
      component_name = figma_data['componentName']&.downcase&.gsub(/[^a-z0-9_]/, '') || 'unknown'
      
      # Map Figma properties to Rails props
      props = {}
      
      # Handle special properties
      if figma_data['text']
        props['text'] = figma_data['text']
      end

      if figma_data['icon'] && figma_data['icon']['name']
        props['icon'] = figma_data['icon']['name']
        props['icon_type'] = figma_data['icon']['type'] || 'solid'
      end

      # Handle size mapping
      if figma_data['properties']&.dig('Size')
        size_mapping = { 'L 24px' => 'large', 'M 16px' => 'medium', 'S 12px' => 'small' }
        props['size'] = size_mapping[figma_data['properties']['Size']] if size_mapping[figma_data['properties']['Size']]
      end

      # Handle emphasis mapping
      if figma_data['properties']&.dig('Emphasis')
        emphasis_mapping = { 'High' => true, 'Low' => false }
        props['emphasized'] = emphasis_mapping[figma_data['properties']['Emphasis']] if emphasis_mapping[figma_data['properties']['Emphasis']]
      end

      # Handle color mapping
      if figma_data['properties']&.dig('Color')
        color_mapping = { 'Grey' => 'neutral', 'Blue' => 'primary', 'Red' => 'danger' }
        props['color'] = color_mapping[figma_data['properties']['Color']] if color_mapping[figma_data['properties']['Color']]
      end

      # Generate Rails code
      if props.empty?
        rails_code = "render Vue::BadgeComponent.new"
      else
        props_string = props.map { |k, v| "#{k}: #{format_value(v)}" }.join(', ')
        rails_code = "render Vue::BadgeComponent.new(#{props_string})"
      end

      # Generate mapping explanation
      explanations = []
      figma_data['properties']&.each do |property_name, property_value|
        if props[property_name.underscore]
          explanations << "Figma's \"#{property_name}: #{property_value}\" maps to #{property_name.underscore}: #{props[property_name.underscore]}"
        end
      end

      {
        success: true,
        component_name: component_name,
        figma_data: figma_data,
        rails_props: props,
        rails_code: rails_code,
        mapping_explanation: explanations.join("\n")
      }.to_json
      
    rescue => e
      status 422
      {
        success: false,
        error: "Mapping failed: #{e.message}",
        component_name: component_name
      }.to_json
    end
  end

  # Simple HTML interface for testing
  get '/test' do
    erb :test_interface
  end

  private

  def format_value(value)
    case value
    when String
      "\"#{value}\""
    when TrueClass, FalseClass
      value.to_s
    when Numeric
      value.to_s
    else
      "\"#{value}\""
    end
  end
end

# HTML template for testing interface
__END__

@@ test_interface
<!DOCTYPE html>
<html>
<head>
  <title>MCP Design System Server - Test Interface</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 40px; }
    .endpoint { margin: 20px 0; padding: 15px; border: 1px solid #ddd; border-radius: 5px; }
    .endpoint h3 { margin-top: 0; }
    button { padding: 10px 15px; background: #007bff; color: white; border: none; border-radius: 3px; cursor: pointer; }
    button:hover { background: #0056b3; }
    .result { margin-top: 10px; padding: 10px; background: #f8f9fa; border-radius: 3px; white-space: pre-wrap; }
    input, textarea { width: 100%; padding: 8px; margin: 5px 0; border: 1px solid #ddd; border-radius: 3px; }
  </style>
</head>
<body>
  <h1>🧪 MCP Design System Server - Test Interface</h1>
  
  <div class="endpoint">
    <h3>1. List Components</h3>
    <button onclick="testEndpoint('/mcp/components')">Test Components List</button>
    <div id="components-result" class="result"></div>
  </div>

  <div class="endpoint">
    <h3>2. Get Badge Component</h3>
    <button onclick="testEndpoint('/mcp/components/badge')">Get Badge Docs</button>
    <div id="badge-result" class="result"></div>
  </div>

  <div class="endpoint">
    <h3>3. Figma to Rails Mapping</h3>
    <textarea id="figma-data" rows="10" placeholder="Enter Figma data JSON...">{
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
}</textarea>
    <button onclick="testFigmaMapping()">Test Figma Mapping</button>
    <div id="figma-result" class="result"></div>
  </div>

  <div class="endpoint">
    <h3>4. List Assets</h3>
    <button onclick="testEndpoint('/mcp/assets')">Test Assets List</button>
    <div id="assets-result" class="result"></div>
  </div>

  <div class="endpoint">
    <h3>5. List Tokens</h3>
    <button onclick="testEndpoint('/mcp/tokens')">Test Tokens List</button>
    <div id="tokens-result" class="result"></div>
  </div>

  <script>
    async function testEndpoint(url) {
      try {
        const response = await fetch(url);
        const data = await response.json();
        document.getElementById(url.replace('/', '-').substring(1) + '-result').textContent = JSON.stringify(data, null, 2);
      } catch (error) {
        document.getElementById(url.replace('/', '-').substring(1) + '-result').textContent = 'Error: ' + error.message;
      }
    }

    async function testFigmaMapping() {
      try {
        const figmaData = JSON.parse(document.getElementById('figma-data').value);
        const response = await fetch('/mcp/map-figma-to-rails', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ figma_data: figmaData })
        });
        const data = await response.json();
        document.getElementById('figma-result').textContent = JSON.stringify(data, null, 2);
      } catch (error) {
        document.getElementById('figma-result').textContent = 'Error: ' + error.message;
      }
    }
  </script>
</body>
</html> 