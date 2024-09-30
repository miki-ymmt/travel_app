require 'rails_helper'

RSpec.describe 'Routing', type: :routing do
  it 'routes to #flights' do
    expect(get: '/flights').to route_to('flights#index')
  end
end
