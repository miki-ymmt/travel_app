require 'rails_helper'

RSpec.describe 'Routing to trips', type: :routing do
  it 'routes to #add_todo' do
    expect(post: '/trips/1/add_todo').to route_to('trips#add_todo', id: '1')
  end

  it 'routes to #update_todo' do
    expect(patch: '/trips/1/update_todo/2').to route_to('trips#update_todo', id: '1', todo_id: '2')
  end

  it 'routes to #destroy_todo' do
    expect(delete: '/trips/1/destroy_todo/2').to route_to('trips#destroy_todo', id: '1', todo_id: '2')
  end
end
