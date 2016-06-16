require 'spec_helper'

describe server(:nginx) do
  describe http('http://haproxy:8080/') do
    it '/ responds with 200' do
      expect(response.status).to eq(200)
    end

    it '/ responds with content including "Active connections:"' do
      expect(response.body).to include('Active connections:')
    end
  end
end
