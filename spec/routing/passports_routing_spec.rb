require 'rails_helper'

RSpec.describe 'Routing to passports', type: :routing do
  it 'routes to #new' do
    expect(get: '/passports/new').to route_to('passports#new')
  end

  it 'routes to #create' do
    expect(post: '/passports').to route_to('passports#create')
  end

  it 'routes to #show' do
    expect(get: '/passports/1').to route_to('passports#show', id: '1')
  end

  it 'routes to #edit' do
    expect(get: '/passports/1/edit').to route_to('passports#edit', id: '1')
  end

  it 'routes to #update' do
    expect(patch: '/passports/1').to route_to('passports#update', id: '1')
    expect(put: '/passports/1').to route_to('passports#update', id: '1')
  end

  it 'routes to #destroy' do
    expect(delete: '/passports/1').to route_to('passports#destroy', id: '1')
  end
end
