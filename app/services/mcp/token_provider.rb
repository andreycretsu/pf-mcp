module MCP
  class TokenProvider
    def self.list_all
      [
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
          name: 'danger',
          display_name: 'Danger',
          category: 'colors',
          type: 'color',
          value: '#EF4444',
          usage_in_components: ['badge', 'button', 'alert']
        },
        {
          name: 'large',
          display_name: 'Large',
          category: 'sizes',
          type: 'size',
          value: '24px',
          usage_in_components: ['badge', 'button', 'avatar']
        },
        {
          name: 'medium',
          display_name: 'Medium',
          category: 'sizes',
          type: 'size',
          value: '16px',
          usage_in_components: ['badge', 'button', 'avatar']
        },
        {
          name: 'small',
          display_name: 'Small',
          category: 'sizes',
          type: 'size',
          value: '12px',
          usage_in_components: ['badge', 'button', 'avatar']
        }
      ]
    end

    def self.get_token_docs(token_name)
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
        }
      when 'large'
        {
          name: 'large',
          display_name: 'Large',
          category: 'sizes',
          description: 'Large size variant',
          value: '24px',
          usage_examples: [
            {
              title: 'In Badge Component',
              description: 'Using large size in a badge',
              rails_code: 'render Vue::BadgeComponent.new(text: "Important", size: "large")',
              vue_code: '<PfBadge size="large">Important</PfBadge>'
            }
          ],
          figma_mapping: {
            'L 24px' => 'large'
          }
        }
      else
        nil
      end
    end
  end
end 