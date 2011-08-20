require 'test_helper'

class AiTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Ai.new.valid?
  end
end
