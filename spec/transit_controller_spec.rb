require_relative 'spec_helper'

describe 'GET /' do
  it 'Renders a successful status' do
    get '/'
    expect(last_response.status).to eq(200)
  end
end

