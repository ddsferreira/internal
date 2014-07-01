class Module
  def internal_instance_methods
    @@internal_instance_methods ||= []
  end

  def internal_methods
    @@internal_methods ||= []
  end

  def internal(meth)
    if caller[0] =~ /\A.*`singletonclass'\z/
      caller_stack = 1
      eval_string = 'self.name'
      internal_instance_methods << meth
    else
      caller_stack = 1
      eval_string = 'self.class.name'
      internal_methods << meth
    end

    # alias to create instance method alias
    #self.instance_eval("alias_method :__rbint_#{meth}, :#{meth}")
    # same thing as
    alias_method :"__rbint_#{meth}", meth

    # create class method
    self.class_eval( "def #{meth}
      require 'binding_of_caller'
      cn = binding.of_caller(#{caller_stack}).eval('#{eval_string}')
      a = self.class.namespace_root(cn)
      b = self.class.namespace_root(#{eval_string})
      if a != b
        raise NoMethodError 
      end
      send('__rbint_#{meth}')
    end")
  end

  def namespace_root(namespace)
    namespace.sub!(/\A(([A-Z]{1}[a-z_]*)+)((::.*))*\z/, '\\1')
  end
  public :namespace_root
end
