require 'spec_helper'

describe server(:nginx) do
  before(:all) do
    %x(docker exec docker-nginx-t touch /var/run/unicorn/maintenance)
  end

  after(:all) do
    %x(docker exec docker-nginx-t rm /var/run/unicorn/maintenance)
  end

  describe http(
    'http://haproxy:8888',
    headers: {
      'Host' => 'www.example.com',
      'X-Forwarded-Proto' => 'https',
    }
  ) do
    it '/ responds with 302 in maintenance mode' do
      expect(response.status).to eq(302)
    end
    it '/ redirects to http://www.example.com/maintenance.html in maintenance mode' do
      expect(response.headers['Location']).to eq('http://www.example.com/maintenance.html')
    end
  end

  describe http(
    'http://haproxy:8888/healthcheck',
    headers: {
      'Host' => 'www.example.com',
      'X-Forwarded-Proto' => 'https',
    }
  ) do
    it '/healthcheck responds with 200 in maintenance mode' do
      expect(response.status).to eq(200)
    end

    it '/healthcheck responds with content including "success" in maintenance mode' do
      expect(response.body).to include('success')
    end
  end

  describe http(
    'http://haproxy:8888',
    headers: {
      'Host' => 'www.example.com',
      'X-Forwarded-Proto' => 'https',
      'X-Forwarded-For' => '203.0.113.1'
    }
  ) do
    it '/ responds with 200 when access from whitelisted IP address in maintenance mode' do
      expect(response.status).to eq(200)
    end
  end

  describe http(
    'http://haproxy:8888',
    headers: {
      'Host' => 'www.example.com',
      'X-Forwarded-Proto' => 'https',
      'X-Forwarded-For' => '192.0.2.1'
    }
  ) do
    it '/ responds with 403 when access from blacklisted IP address in maintenance mode' do
      expect(response.status).to eq(403)
    end
  end
end
