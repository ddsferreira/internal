require 'internal/version'
require 'binding_of_caller'

module Internal
  def caller_internal?
    caller_namespace_root == class_namespace_root
  end
  private :caller_internal?

  def caller_namespace_root
    namespace_root binding.of_caller(3).eval('self.class.name')
  end
  private :caller_namespace_root

  def class_namespace_root
    namespace_root self.name
  end
  private :class_namespace_root

  def internal_methods
    @internal_methods ||= protected_methods
  end
  private :internal_methods

  def internal_instance_methods
    @internal_instance_methods ||= protected_instance_methods
  end
  private :internal_instance_methods

  def namespace_root(namespace)
    namespace.sub!(/\A([A-Z][a-z_]*)((::.*))*\z/, '\\1')
  end
  private :namespace_root

  def new *args
    caller_internal? ? set_internal_instance_methods_public! : set_internal_instance_methods_protected!
    super *args
  end
  public :new

  def set_internal_class_methods_protected!
    internal_methods.each { |m| self.instance_eval("class << self; protected :#{m}; end") }
  end
  private :set_internal_class_methods_protected!

  def set_internal_class_methods_public!
    internal_methods.each { |m| self.instance_eval("class << self; public :#{m}; end") }
  end
  private :set_internal_class_methods_public!

  def set_internal_instance_methods_protected!
    internal_instance_methods.each { |m| protected m }
  end
  private :set_internal_instance_methods_protected!

  def set_internal_instance_methods_public!
    internal_instance_methods.each { |m| public m } 
  end
  private :set_internal_instance_methods_public!

  alias_method :old_public_method_defined?, :public_method_defined?
  def public_method_defined?(*args)
    binding.pry
    old_public_method_defined?(*args)
  end
  public :public_method_defined?

  alias_method :old_public_methods, :public_methods
  def public_methods
    ret = old_public_methods
    ret << internal_methods if caller_internal?
  end
  public :public_methods

  alias_method :old_protected_methods, :protected_methods
  def protected_methods
    caller_internal? ? [] : internal_methods
  end
  protected :protected_methods

  def work_internal_class_methods!
    internal_methods.each do |m|
      self.instance_eval("alias_method old_#{m} #{m}; def #{m}(*args); raise NoMethodError if !caller_internal?; old_#{m}(*args); end")
    end
  end
  private :work_internal_class_methods!
end
