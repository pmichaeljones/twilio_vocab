require "sinatra"
require "sinatra/activerecord"
require 'sinatra/base'
require 'sinatra/assetpack'

class App < Sinatra::Base
  register Sinatra::AssetPack
  assets do
    js :application, [
      'js/*.js'
    ]

    css :application, [
      '/css/foundation.css',
      '/css/foundation.min.css',
      '/css/normalize.css',
     ]

    js_compression :jsmin
    css_compression :sass
  end

  get '/' do
    haml :index
  end

end

