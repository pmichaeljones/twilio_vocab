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
  #binding.pry
  if params[:Body].downcase == "vocab"
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "We don't recognize your number. Want to set up an account? It takes one minute, no joke."
    end
    session["known_user"] == true
    twiml.text
  else
    binding.pry
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "Back for more I see."
    end
    twiml.text
  end
end


get '/:number' do
  @user = User.find_by(phone_number: params[:number])
  if @user
    haml :user_page
  else
    haml :error_page
  end
end



