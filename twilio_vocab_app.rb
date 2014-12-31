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
    @user = User.find_by(phone_number: params[:From][2..11])
    word = params[:Body]
    if @user
      definition_array = DefinitionAPI::Definition.get_definition(word)
      if definition_array[1] == nil
        send_no_word_available(@user.id)
      else
        @user.definitions.create(word: definition_array[0], definition: definition_array[1])
        send_successful_new_word_text(@user.id, definition_array)
      end
    else
      send_error_text(params[:From][2..11])
    end
  end

end

def create_new_user(phone_number)
  @user = User.new
  @user.phone_number = phone_number
  @user.save
  send_confirmation_text(@user.id)
end

def send_no_word_available(user_id)
  @user = User.find(user_id)
  @client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]

  message = @client.account.messages.create(
    :body => "Sorry, but we were unable to find a definition for that word. Did you spell it correctly? Please retry.",
    :to => "+1#{@user.phone_number}",
    :from => "+17208973141"
    )
  puts message.to
end

def send_error_text(number)
  @client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]

  message = @client.account.messages.create(
    :body => "We don't recognize you as a user of this app. Text VOCAB to this number to become a user.",
    :to => "+1#{number}",
    :from => "+17208973141"
    )
  puts message.to
end

def send_successful_new_word_text(user_id, definition_array)
  @user = User.find(user_id)
  @client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]

  message = @client.account.messages.create(
    :body => "Word: #{definition_array[0].upcase} * Definition: '#{definition_array[1].capitalize}' * Successfully added to your page: http://app.com/#{params[:From][2..11]}",
    :to => "+1#{@user.phone_number}",
    :from => "+17208973141"
    )
  puts message.to
end

def send_confirmation_text(user_id)
  @user = User.find(user_id)
  @client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]

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