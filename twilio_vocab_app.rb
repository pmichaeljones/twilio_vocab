require "sinatra"
require "sinatra/activerecord"
require "pry"
require_relative "models/user.rb"
require_relative "models/definition.rb"


get '/' do
  haml :index
end

get '/:number' do
  @user = User.find_by(phone_number: params[:number])
  if @user
    haml :user_page
  else
    haml :error_page
  end
end



