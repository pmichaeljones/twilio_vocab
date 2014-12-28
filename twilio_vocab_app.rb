require "sinatra"
require "sinatra/activerecord"
require "pry"
require "twilio-ruby"
require_relative "models/user.rb"
require_relative "models/definition.rb"

enable :sessions

get '/' do
  haml :index
end

get '/incoming' do
  session["known_user"] ||= false

  if session["known_user"] == false
    message = "We don't recognize your number. Want to set up an account? It takes one minute, no joke."
  else
    message = "We've seen you before. Welcome back."
  end

  response = Twilio::TwiML::Response.new do |r|
    r.Message message
  end

  session["known_user"] = true
  response.text
end


get '/:number' do
  @user = User.find_by(phone_number: params[:number])
  if @user
    haml :user_page
  else
    haml :error_page
  end
end



