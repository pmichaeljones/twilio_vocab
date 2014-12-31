require "sinatra"
require "sinatra/activerecord"
require "pry"
require "twilio-ruby"
require_relative "definition_api.rb"
require_relative "models/user.rb"
require_relative "models/definition.rb"

include DefinitionAPI

enable :sessions

get '/' do
  haml :index
end

get '/incoming' do

  if params[:Body].downcase == "vocab" || params[:Body].downcase == "no"

    session["current_user"] ||= false

    message = "We don't recognize your number. Want to set up an account? It takes one minute, no joke. Reply Yes or No." if session["current_user"] == false

    message = "Okay. Just text Vocab to this number in the future if you want to sign up." if params[:Body].downcase == "no"

    response = Twilio::TwiML::Response.new do |r|
      r.Message message
    end

    response.text

  elsif params[:Body].downcase == "yes"

    create_new_user(params[:From][2..11])

  else
    @user = User.find_by(phone_number: params[:From][2.11])
    word = params[:Body]
    if @user
      DefintionAPI::Defintion.look_up(word)
    end
  end

end

def create_new_user(phone_number)
  binding.pry
  @user = User.new
  @user.phone_number = phone_number
  @user.save
  send_confirmation_text(@user.id)
end

def send_confirmation_text(user_id)
  binding.pry
  @user = User.find(user_id)
  account_sid = ENV["TWILIO_SID"]
  auth_token = ENV["TWILIO_TOKEN"]
  @client = Twilio::REST::Client.new account_sid, auth_token

  message = @client.account.messages.create(
    :body => "You're all ready to go. Text an unknown word to this number. Check your defintions at http://app.com/#{params[:From][2..11]}",
    :to => "+1#{@user.phone_number}",
    :from => "+17208973141"
    )
  puts message.to
end

get '/:number' do
  @user = User.find_by(phone_number: params[:number])
  if @user
    haml :user_page
  else
    haml :error_page
  end
end