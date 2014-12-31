require 'minitest/autorun'

class DefinitionTest < MiniTest::Unit::TestCase
  def test_it_works
    assert_equal "hello world!", Definition.answer
  end
end

