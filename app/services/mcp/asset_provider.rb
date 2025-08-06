module MCP
  class AssetProvider
    def self.list_all
      [
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
    end

    def self.get_asset_docs(asset_name)
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
        }
      else
        nil
      end
    end
  end
end 