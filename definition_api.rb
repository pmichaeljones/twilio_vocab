require 'nokogiri'
require 'net/http'
require 'pry'

module DefinitionAPI

  class Definition

    def self.look_up(word)
      binding.pry
    end


    def self.get_definition(word)
      xml = Nokogiri::XML(open("http://www.stands4.com/services/v2/defs.php?uid=3692&tokenid=#{ENV["DEFINITION_API_TOKEN"]}&word=#{word}"))
      binding.pry
    end


  end

end