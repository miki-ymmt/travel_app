require 'rails_helper'

RSpec.describe 'Routing to login', type: :routing do
  it 'routes to #new' do
    expect(get: '/login').to route_to('user_sessions#new')
  end

  it 'routes to #create' do
    expect(post: '/login').to route_to('user_sessions#create')
  end
end