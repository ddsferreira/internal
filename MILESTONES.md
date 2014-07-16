# MILESTONES

### v0.1.0

* Module#internal method 
* Should be implemented as a ruby extension
* Targetting ruby 2.1.2 version
* When explicitly specified Module#internal should be used like remaining access modifiers.

~~~ ruby
class foo
  def bar
  end
  internal :bar

  def baz
  end
  internal :baz
end
~~~

* Implicit use is out of scope for this release

~~~ ruby
class foo
  internal

  def bar
  end

  def baz
  end
end
~~~

* It should not impact ruby performance
* It should be usable in production environment

### v0.1.0.alpha.3

* Create cruby extension 
* Create Module#internal method inside cruby extension
* Keep with monkey patched ruby code to allow tests to pass

### v0.1.0.alpha2

* Extend Module class with new Module#internal method.
* Module#internal should be used the same way as Module#public, Module#private or Module#protected when explicitly specified.
* Implicit use is out of scope for the time being.
* We will use monkey patching here overriding several standard methods.
* This is a very primitive prove of concept. 
