# frozen_string_literal: true
require 'test_helper'
require 'interactor'

class Greeting
  include Interactor

  def initialize(name)
    @name = name
  end

  def call
    if @name.empty?
      fail! 'name is empty'
    else
      context[:message] = "Hello, #{@name}"
    end
  end
end

class EmptyCase
  include Interactor
end

class InteractorTest < Minitest::Test
  def test_not_implemented_error
    assert_raises NotImplementedError do
      EmptyCase.call
    end
  end

  def test_success
    greeting = Greeting.call('Jian Weihang')
    assert greeting.success?
    assert_equal 'Hello, Jian Weihang', greeting[:message]
  end

  def test_error
    greeting = Greeting.call('')
    refute greeting.success?
    assert_equal 'name is empty', greeting[:error]
  end
end
