require 'rails_helper'

RSpec.describe 'Routing to lines', type: :routing do

  it 'routes to line_bot#callback' do
    expect(post: '/callback').to route_to('line_bot#callback')
  end

  it 'routes to line_auth#link' do
    expect(get: '/line_link').to route_to('line_auth#link')
  end

  it 'routes to line_auth#callback' do
    expect(get: '/line_auth/callback').to route_to('line_auth#callback')
  end
end