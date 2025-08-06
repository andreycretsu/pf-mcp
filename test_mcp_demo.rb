#!/usr/bin/env ruby

# Simple demonstration of the MCP Design System Server functionality
# This shows what the server would do without needing to run a web server

puts "🧪 MCP Design System Server - Demo"
puts "=" * 50

# Simulate the MCP server responses
class MCPDemo
  def self.list_components
    {
      components: [
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
      ],
      total: 3,
      frameworks: ['rails', 'vue']
    }
  end

  def self.get_badge_component
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
        ]
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
        ]
      }
    }
  end

  def self.map_figma_to_rails(figma_data)
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
      if props[property_name.downcase.gsub(/[^a-z0-9_]/, '')]
        normalized_name = property_name.downcase.gsub(/[^a-z0-9_]/, '')
        explanations << "Figma's \"#{property_name}: #{property_value}\" maps to #{normalized_name}: #{props[normalized_name]}"
      end
    end

    {
      success: true,
      component_name: component_name,
      figma_data: figma_data,
      rails_props: props,
      rails_code: rails_code,
      mapping_explanation: explanations.join("\n")
    }
  end

  private

  def self.format_value(value)
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

# Demo the functionality
puts "\n1. 📋 List Components"
components = MCPDemo.list_components
puts "   Total components: #{components[:total]}"
components[:components].each do |component|
  puts "   - #{component[:display_name]} (#{component[:frameworks].join(', ')})"
end

puts "\n2. 🔍 Get Badge Component Documentation"
badge_docs = MCPDemo.get_badge_component
puts "   Rails class: #{badge_docs[:rails][:class_name]}"
puts "   Vue component: #{badge_docs[:vue][:component_name]}"
puts "   Props count: #{badge_docs[:rails][:props].length}"

puts "\n3. 🎨 Figma to Rails Mapping (Your Workflow)"
figma_data = {
  "componentName" => "Badge",
  "properties" => {
    "Size" => "L 24px",
    "Emphasis" => "High",
    "Color" => "Grey",
    "Icon" => "true",
    "Label" => "Badge"
  },
  "icon" => {
    "name" => "star",
    "type" => "solid"
  },
  "text" => "Badge"
}

result = MCPDemo.map_figma_to_rails(figma_data)
puts "   ✅ Success: #{result[:success]}"
puts "   📝 Generated Rails code:"
puts "   #{result[:rails_code]}"
puts "   🔄 Mapping explanation:"
puts "   #{result[:mapping_explanation]}"

puts "\n" + "=" * 50
puts "🎉 MCP Server Demo Complete!"
puts "\nThis demonstrates how the MCP server would:"
puts "1. List available components from both Rails and Vue"
puts "2. Provide detailed component documentation"
puts "3. Map Figma properties to Rails component props"
puts "4. Generate Rails code for feature developers"
puts "\nNext steps:"
puts "1. Integrate with your actual Lookbook and Storybook"
puts "2. Add more component mappings"
puts "3. Configure AI tools to use this MCP server" 