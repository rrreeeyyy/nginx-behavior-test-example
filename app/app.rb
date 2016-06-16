require 'json'
require 'sinatra'

class App < Sinatra::Base
  set :protection, :except => [:ip_spoofing]
  get '/healthcheck' do
    'success'
  end
  get '/*' do
    env.to_json
  end
end
