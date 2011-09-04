require 'test_helper'

class AiTest < ActiveSupport::TestCase
  test "name is required" do
    ai = ais(:tigh)
    ai.name = nil
    assert !ai.valid?
    assert ai.errors.include?(:name)
  end

  test "name must be unique" do
    ai = ais(:chief)
    ai.name = ais(:tigh).name
    assert !ai.valid?
    assert ai.errors.include?(:name)
  end

  test "file_name is required" do
    ai = ais(:tigh)
    ai.file_name = nil
    assert !ai.valid?
    assert ai.errors.include?(:file_name)
  end

  test "file_name must end in .rb" do
    ai = ais(:tigh)
    ai.file_name = "derp.h"
    assert !ai.valid?
    assert ai.errors.include?(:file_name)
  end

  test "source is required" do
    ai = ais(:tigh)
    ai.source = nil
    assert !ai.valid?
    assert ai.errors.include?(:source)
  end

  test "user is required" do
    ai = ais(:tigh)
    ai.user = nil
    assert !ai.valid?
    assert ai.errors.include?(:user)
  end
end
