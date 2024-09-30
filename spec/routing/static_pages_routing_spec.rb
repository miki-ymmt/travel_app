require 'rails_helper'

RSpec.describe 'StaticPages', type: :routing do
  it 'routes to #policy' do
    expect(get: '/statistic_pages/policy').to route_to('static_pages#policy')
  end

  it 'routes to #terms' do
    expect(get: '/statistic_pages/terms').to route_to('static_pages#terms')
  end
end
