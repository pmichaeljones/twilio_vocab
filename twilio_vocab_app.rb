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

  if params[:Body].downcase == "vocab" || params[:Body].downcase == "yes" || params[:Body].downcase == "no"

    session["current_user"] ||= false

    message = "We don't recognize your number. Want to set up an account? It takes one minute, no joke. Reply Yes or No." if session["current_user"] == false

    message = "Okay. Just text Vocab to this number in the future if you want to sign up." if params[:Body].downcase == "no"

    redirect '/create_new_user' if params[:Body].downcase == "yes"

    response = Twilio::TwiML::Response.new do |r|
      r.Message message
    end

    session["current_user"] = true

    response.text

  else
    #run code for checking user status and getting defintions
  end

end

get '/create_new_user' do
  binding.pry
  @user = User.new
  @user.phone_number = params[:From][2..11]
  @user.save
  response = Twilio::TwiML::Response.new do |r|
    r.Message "You're all ready to go. Text an unknown word to this number. Check your defintions at http://app.com/#{params[:From][2..11]}"
  end
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


#person texts vocab
#see if they're a current user. If not, ask to sign up

#if person is a current user, run the dictionary API method





