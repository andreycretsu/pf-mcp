module MCP
  class VueDocsProvider
    VUE_DOCS_PATH = Rails.root.join("docs/vue-components.json")
    STORYBOOK_URL = "https://storybook.stage-81y92gtmor-peopleforce.dev"

    def self.list_components
      # Try to get from JSON file first, then fallback to Storybook API
      if File.exist?(VUE_DOCS_PATH)
        load_from_json
      else
        load_from_storybook
      end
    rescue => e
      Rails.logger.error "Error fetching Vue components: #{e.message}"
      []
    end

    def self.get_component_docs(component_name)
      case component_name
      when 'badge'
        {
          name: 'badge',
          framework: 'vue',
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
            },
            {
              title: 'Large Primary Badge',
              description: 'Large badge with primary color',
              code: '<PfBadge size="large" color="primary">Important</PfBadge>'
            }
          ],
          figma_mapping: {
            'Size' => { 'L 24px' => 'size="large"', 'M 16px' => 'size="medium"', 'S 12px' => 'size="small"' },
            'Emphasis' => { 'High' => 'emphasized', 'Low' => nil },
            'Color' => { 'Grey' => 'color="neutral"', 'Blue' => 'color="primary"', 'Red' => 'color="danger"' },
            'Icon' => { 'true' => 'icon="icon_name"', 'false' => nil },
            'Label' => { 'text' => 'inner text content' }
          }
        }
      else
        nil
      end
    end

    def self.component_exists?(component_name)
      list_components.any? { |c| c[:name] == component_name }
    end

    private

    def self.load_from_json
      data = JSON.parse(File.read(VUE_DOCS_PATH))
      data['components'].map do |component|
        {
          name: normalize_name(component['displayName']),
          display_name: component['displayName'],
          framework: 'vue',
          path: component['sourcePath'],
          available_in_storybook: true
        }
      end
    rescue JSON::ParserError => e
      Rails.logger.error "Error parsing Vue components JSON: #{e.message}"
      []
    end

    def self.load_from_storybook
      # This would make an API call to your Storybook
      # For now, returning sample data
      [
        {
          name: 'badge',
          display_name: 'Badge',
          framework: 'vue',
          path: 'src/components/Badge.vue',
          available_in_storybook: true
        },
        {
          name: 'button',
          display_name: 'Button',
          framework: 'vue',
          path: 'src/components/Button.vue',
          available_in_storybook: true
        }
      ]
    end

    def self.normalize_name(name)
      name.to_s.underscore.gsub(/[^a-z0-9_]/, '')
    end
  end
end 