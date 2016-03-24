require 'test_helper'
require 'use_case'

class Greeting
  include UseCase

  def initialize(name)
    @name = name
  end

  def call
    if @name.empty?
      errors[:name] = 'name is empty'
    else
      results[:message] = "Hello, #{@name}"
    end
  end
end

class EmptyCase
  include UseCase
end

class UseCaseTest < Minitest::Test
  def test_not_implemented_error
    assert_raises NotImplementedError do
      EmptyCase.call
    end
  end

  def test_success
    greeting = Greeting.call('Jian Weihang')
    assert greeting.success?
    assert_equal 'Hello, Jian Weihang', greeting.results[:message]
  end

  def test_error
    greeting = Greeting.call('')
    refute greeting.success?
    assert_equal 'name is empty', greeting.errors[:name]
  end
end