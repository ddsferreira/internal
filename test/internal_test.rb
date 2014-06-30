$:.unshift(File.expand_path('../../lib', __FILE__))

require 'pry'
require 'minitest'
require 'minitest/autorun'
require 'internal'

module Foo
end

class Foo::Bar
  extend Internal

  def initialize(*args)
    @args = args
  end
  
  def bar
    @args
  end
  protected :bar

  class << self
    def baz
      binding.pry
      'baz'
    end
    public :baz
  end
end

class Foo::Baz
  def self.baz
    Foo::Bar.baz
  end

  def bar(*args)
    Foo::Bar.new(*args).bar
  end
end

class Bar
  def self.baz
    Foo::Bar.baz
  end

  def bar(*args)
    Foo::Bar.new(*args).bar
  end
end

class InternalTest < Minitest::Test
  def test_internal_class_instance_method
    assert_equal ::Foo::Baz.new.bar('a'), ['a']
  end

  def test_internal_class_singleton_method
    binding.pry
    assert_equal ::Foo::Baz.baz, 'baz'
  end

  def test_external_class_instance_method
    assert_raises(NoMethodError) { ::Bar.new.bar('a') }
  end

  def test_external_class_singleton_method
    assert_raises(NoMethodError) { ::Bar.baz }
  end
end
