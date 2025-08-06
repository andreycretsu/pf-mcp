module MCP
  class RailsDocsProvider
    def self.list_components
      # Get components from Lookbook
      begin
        # This would integrate with Lookbook's API
        # For now, returning sample data based on your existing components
        [
          {
            name: 'tab_bar_primary',
            display_name: 'Tab Bar Primary',
            framework: 'rails',
            path: 'app/components/ui/tab_bar_primary_component.rb',
            available_in_lookbook: true
          },
          {
            name: 'badge',
            display_name: 'Badge',
            framework: 'rails',
            path: 'app/components/vue/badge_component.rb',
            available_in_lookbook: true
          },
          {
            name: 'button',
            display_name: 'Button',
            framework: 'rails',
            path: 'app/components/ui/button_component.rb',
            available_in_lookbook: true
          }
        ]
      rescue => e
        Rails.logger.error "Error fetching Rails components: #{e.message}"
        []
      end
    end

    def self.get_component_docs(component_name)
      case component_name
      when 'badge'
        {
          name: 'badge',
          framework: 'rails',
          class_name: 'Vue::BadgeComponent',
          description: 'A badge component for displaying status, labels, or notifications',
          props: [
            { name: 'text', type: 'String', required: true, description: 'The text content of the badge' },
            { name: 'size', type: 'String', required: false, default: 'medium', options: ['small', 'medium', 'large'], description: 'Size of the badge' },
            { name: 'color', type: 'String', required: false, default: 'neutral', options: ['neutral', 'primary', 'danger'], description: 'Color variant of the badge' },
            { name: 'icon', type: 'String', required: false, description: 'Icon name to display' },
            { name: 'icon_type', type: 'String', required: false, default: 'solid', options: ['solid', 'regular'], description: 'Icon style' },
            { name: 'emphasized', type: 'Boolean', required: false, default: false, description: 'Whether the badge should be emphasized' },
            { name: 'wrap_text', type: 'Boolean', required: false, default: false, description: 'Whether text should wrap' }
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
            },
            {
              title: 'Large Primary Badge',
              description: 'Large badge with primary color',
              code: 'render Vue::BadgeComponent.new(text: "Important", size: "large", color: "primary")'
            }
          ],
          figma_mapping: {
            'Size' => { 'L 24px' => 'size: "large"', 'M 16px' => 'size: "medium"', 'S 12px' => 'size: "small"' },
            'Emphasis' => { 'High' => 'emphasized: true', 'Low' => 'emphasized: false' },
            'Color' => { 'Grey' => 'color: "neutral"', 'Blue' => 'color: "primary"', 'Red' => 'color: "danger"' },
            'Icon' => { 'true' => 'icon: "icon_name"', 'false' => nil },
            'Label' => { 'text' => 'text: "text_value"' }
          }
        }
      when 'tab_bar_primary'
        {
          name: 'tab_bar_primary',
          framework: 'rails',
          class_name: 'UI::TabBarPrimaryComponent',
          description: 'Primary tab bar component for navigation',
          props: [
            { name: 'tabs', type: 'Array', required: true, description: 'Array of tab objects' }
          ],
          usage_examples: [
            {
              title: 'Basic Tab Bar',
              description: 'Simple tab bar with two tabs',
              code: 'render UI::TabBarPrimaryComponent.new do |c|
  c.with_tabs([
    { name: "Details", href: "#details", active: true },
    { name: "Comments", href: "#comments", active: false }
  ])
end'
            }
          ]
        }
      else
        nil
      end
    end

    def self.component_exists?(component_name)
      list_components.any? { |c| c[:name] == component_name }
    end
  end
end 