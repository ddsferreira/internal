$:.unshift(File.expand_path('../../lib', __FILE__))

require 'module'
require 'minitest'
require 'minitest/autorun'
require 'pry'

module Foo
  class Foo::Bar
    def bar
      'bar'
    end
    internal :bar

    class << self
      def baz
        'baz'
      end
      internal :baz
    end
  end
end

class Foo::Baz
  def self.baz
    Foo::Bar.baz
  end

  def bar
    Foo::Bar.new.bar
  end
end

class InternalTest < Minitest::Test
  def test_internal_instance_method_call
    assert_equal 'bar', ::Foo::Baz.new.bar
  end

  def test_internal_class_method_call
    assert_equal 'baz', ::Foo::Baz.baz
  end

  def test_external_instance_method_call
    assert_raises(NoMethodError) { Foo::Bar.new.bar }
  end

  def test_external_class_method_call
    assert_raises(NoMethodError) { Foo::Bar.baz }
  end
end


