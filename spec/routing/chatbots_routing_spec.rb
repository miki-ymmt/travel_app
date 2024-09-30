require 'rails_helper'

RSpec.describe 'Routing', type: :routing do
  it 'routes to #ask' do
    expect(get: '/chatbots/ask').to route_to('chatbots#ask')
  end

  it 'routes to #answer' do
    expect(post: '/chatbots/answer').to route_to('chatbots#answer')
  end
end
