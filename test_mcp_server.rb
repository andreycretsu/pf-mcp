#!/usr/bin/env ruby

# Test script for the MCP Design System Server
# This demonstrates the Figma → Vue → Rails mapping workflow

require 'net/http'
require 'json'
require 'uri'

class MCPTester
  BASE_URL = 'http://localhost:3000'

  def self.test_all_endpoints
    puts "🧪 Testing MCP Design System Server\n"
    puts "=" * 50

    test_root_endpoint
    test_list_components
    test_get_badge_component
    test_figma_to_rails_mapping
    test_list_assets
    test_list_tokens
  end

  def self.test_root_endpoint
    puts "\n1. Testing root endpoint..."
    response = get('/')
    if response
      puts "✅ Root endpoint working"
      puts "   Message: #{response['message']}"
      puts "   Version: #{response['version']}"
    end
  end

  def self.test_list_components
    puts "\n2. Testing list components..."
    response = get('/mcp/components')
    if response
      puts "✅ Components endpoint working"
      puts "   Total components: #{response['total']}"
      puts "   Components: #{response['components'].map { |c| c['name'] }.join(', ')}"
    end
  end

  def self.test_get_badge_component
    puts "\n3. Testing get badge component..."
    response = get('/mcp/components/badge')
    if response
      puts "✅ Badge component found"
      puts "   Rails class: #{response['rails']['class_name']}"
      puts "   Vue component: #{response['vue']['component_name']}"
      puts "   Props count: #{response['rails']['props'].length}"
    end
  end

  def self.test_figma_to_rails_mapping
    puts "\n4. Testing Figma to Rails mapping..."
    
    # This matches your example workflow
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

    response = post('/mcp/map-figma-to-rails', { figma_data: figma_data })
    if response && response['success']
      puts "✅ Figma to Rails mapping working"
      puts "   Generated Rails code:"
      puts "   #{response['rails_code']}"
      puts "   Mapping explanation:"
      puts "   #{response['mapping_explanation']}"
    else
      puts "❌ Figma to Rails mapping failed"
      puts "   Error: #{response['error']}" if response
    end
  end

  def self.test_list_assets
    puts "\n5. Testing list assets..."
    response = get('/mcp/assets')
    if response
      puts "✅ Assets endpoint working"
      puts "   Total assets: #{response['total']}"
      puts "   Assets: #{response['assets'].map { |a| a['name'] }.join(', ')}"
    end
  end

  def self.test_list_tokens
    puts "\n6. Testing list tokens..."
    response = get('/mcp/tokens')
    if response
      puts "✅ Tokens endpoint working"
      puts "   Total tokens: #{response['total']}"
      puts "   Categories: #{response['categories'].join(', ')}"
    end
  end

  private

  def self.get(path)
    uri = URI("#{BASE_URL}#{path}")
    response = Net::HTTP.get_response(uri)
    
    if response.code == '200'
      JSON.parse(response.body)
    else
      puts "❌ GET #{path} failed: #{response.code}"
      nil
    end
  rescue => e
    puts "❌ GET #{path} error: #{e.message}"
    nil
  end

  def self.post(path, data)
    uri = URI("#{BASE_URL}#{path}")
    http = Net::HTTP.new(uri.host, uri.port)
    
    request = Net::HTTP::Post.new(uri)
    request['Content-Type'] = 'application/json'
    request.body = data.to_json
    
    response = http.request(request)
    
    if response.code == '200'
      JSON.parse(response.body)
    else
      puts "❌ POST #{path} failed: #{response.code}"
      nil
    end
  rescue => e
    puts "❌ POST #{path} error: #{e.message}"
    nil
  end
end

# Run the tests
if __FILE__ == $0
  puts "Starting MCP server tests..."
  puts "Make sure the Rails server is running on #{MCPTester::BASE_URL}"
  puts "Run: rails server"
  puts ""
  
  MCPTester.test_all_endpoints
  
  puts "\n" + "=" * 50
  puts "🎉 Tests completed!"
  puts "\nNext steps:"
  puts "1. Integrate with your actual Lookbook and Storybook"
  puts "2. Add more component mappings"
  puts "3. Configure your AI tools to use this MCP server"
end 