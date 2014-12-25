require "sinatra"
require "sinatra/activerecord"
require_relative "models/user.rb"

get '/' do
  haml :index
end

get '/:number' do
  haml :user_page
end



