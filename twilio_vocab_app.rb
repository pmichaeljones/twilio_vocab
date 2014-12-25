require "sinatra"
require "sinatra/activerecord"
require "pry"
require_relative "models/user.rb"


get '/' do
  haml :index
end

get '/dog/:number' do
  haml :user_page
  render :
end



