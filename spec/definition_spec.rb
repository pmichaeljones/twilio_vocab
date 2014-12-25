require_relative '../models/definition.rb'

describe Definition do

  it {should belong_to(:user) }
end
