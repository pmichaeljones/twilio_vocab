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
  binding.pry

  if params[:Body].downcase == "vocab" || params[:Body].downcase == "no" || params[:Body].downcase == "no"

    session["current_user"] ||= false

    message = "We don't recognize your number. Want to set up an account? It takes one minute, no joke. Reply Yes or No." if session["current_user"] == false

    create_new_user(params) if params[:Body].downcase == "yes" and return

    message = "Okay. Just text Vocab to this number in the future if you want to sign up." if params[:Body].downcase == "no"

    response = Twilio::TwiML::Response.new do |r|
      r.Message message
    end

    session["current_user"] = true
    response.text

  else
    #run code for checking user status and getting defintions
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

def create_new_user(params)
  @user = User.new
  @user.phone_number = params[:From][2..11]
end

#person texts vocab
#see if they're a current user. If not, ask to sign up

#if person is a current user, run the dictionary API method





