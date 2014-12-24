require "sinatra"
require "sinatra/activerecord"
require_relative "models/user.rb"

get '/' do
  haml :index
end


