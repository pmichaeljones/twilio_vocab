require_relative '../models/user.rb'

describe User do

  it {should have_many(:definitions) }

end
