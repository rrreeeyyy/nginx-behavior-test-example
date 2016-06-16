describe server(:nginx) do
	describe http(
		'http://haproxy:8888/',
		headers: {
			'Host' => 'www.example.com',
			'X-Forwarded-Proto' => 'https',
		}
	) do
		it '/ responds with 200' do
			expect(response.status).to eq(200)
		end
	end

	describe http(
		'http://haproxy:8888/',
		headers: {
			'Host' => 'www.example.com',
			'X-Forwarded-Proto' => 'https',
      'X-Forwarded-For' => '192.0.2.1',
		}
	) do
    it '/ responds with 403 when access from blacklisted IP address' do
			expect(response.status).to eq(403)
			expect(response.body).to include('Forbidden')
		end
	end
end
