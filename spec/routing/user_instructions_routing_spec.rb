# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Routing', type: :routing do
  it 'routes to #usage_instructions' do
    expect(get: '/usage_instructions').to route_to('pages#usage_instructions')
  end
end
