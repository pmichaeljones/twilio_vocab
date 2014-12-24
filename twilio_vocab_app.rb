require "sinatra"
require "sinatra/activerecord"
require_relative "models/user.rb"

get '/' do
  @users = User.all
  haml :index
end


