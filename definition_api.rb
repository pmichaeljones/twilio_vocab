require 'json'
require 'net/http'

require_relative "env.rb"

module DefinitionAPI

  class Definition

    def self.look_up(word)
      binding.pry
    end


    def self.get_definition(word)
      uri = URI("http://www.stands4.com/services/v2/defs.php?uid=3692&tokenid=#{ENV["DEFINITION_API_TOKEN"]}&word=#{word}")
      binding.pry
      Net::HTTP.get(uri)
    end


  end

end