require 'internal/version'
require 'binding_of_caller'

module Internal
  def new *args
    caller_internal? ? set_internal_instance_methods_public! : set_internal_instance_methods_protected!
    super *args
  end

  def caller_internal?
    caller_namespace_root == class_namespace_root
  end

  def set_internal_instance_methods_public!
    internal_instance_methods.each { |m| public m } 
  end

  def set_internal_instance_methods_protected!
    internal_instance_methods.each { |m| protected m }
  end

  def caller_namespace_root
    namespace_root binding.of_caller(3).eval('self.class.name')
  end

  def class_namespace_root
    namespace_root self.name
  end

  def namespace_root(namespace)
    namespace.sub!(/\A([A-Z][a-z_]*)((::.*))*\z/, '\\1')
  end

  def internal_instance_methods
    @internal_instance_methods ||= protected_instance_methods
  end
end
