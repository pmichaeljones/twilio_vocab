require 'nokogiri'
require 'net/http'
require 'pry'

module DefinitionAPI

  class Definition

    # Makes call to API definition and returns the first definition in string format
    def self.get_definition(word)
      uri = URI("http://www.stands4.com/services/v2/defs.php?uid=3692&tokenid=#{ENV["DEFINITION_API_TOKEN"]}&word=#{word}")
      response = Net::HTTP.get(uri)
      xml = Nokogiri::XML(response)
      definition = xml.css("results result definition")[0].text unless xml.css("results result definition")[0].class == NilClass
      return word, definition
    end

  end


end