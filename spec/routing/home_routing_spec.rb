require 'rails_helper'

RSpec.describe 'Routing', type: :routing do
  it 'routes to #home' do
    expect(get: '/home').to route_to('home#index')
  end
end
