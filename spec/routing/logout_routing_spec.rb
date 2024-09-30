require 'rails_helper'

RSpec.describe 'Routing to logout', type: :routing do
  it 'routes to #delete' do
    expect(delete: '/logout').to route_to('user_sessions#destroy')
  end
end
