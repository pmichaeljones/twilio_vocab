require "sinatra"
require "sinatra/activerecord"
require 'sinatra/base'
require 'sinatra/assetpack'

# class App < Sinatra::Base
#   register Sinatra::AssetPack
#   assets do
#     js :application, [
#       '/js/jquery.js',
#       '/js/app.js'
#       # You can also do this: 'js/*.js'
#     ]

#     css :application, [
#       '/css/jqueryui.css',
#       '/css/reset.css',
#       '/css/foundation.sass',
#       '/css/app.sass'
#      ]

#     js_compression :jsmin
#     css_compression :sass
#   end

# end

  get '/' do
    haml :index
  end