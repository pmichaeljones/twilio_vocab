require_relative '../models/user.rb'
require 'rspec'

describe User do

  it {should have_many(:definitions) }

end

