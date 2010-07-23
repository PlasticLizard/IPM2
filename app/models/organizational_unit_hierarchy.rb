class OrganizationalUnitHierarchy < Array
  def initialize(*args)
    unless args.empty?
      super(args[0].kind_of?(Array) ? args[0] : args)
      self.map!{|type|self.class.context_to_sym(type)}
    end
  end

  def child_of(context, options={})
   idx = index(self.class.context_to_sym(context))
   raise "#{context} is not in the hierarchy, which has the following levels: #{self.inspect}" unless idx
   child = idx >= length-1 ? nil : self[idx+1]
   return nil unless child
   options[:as] == :symbol ? child : child.to_s.classify.constantize
  end

  def parent_of(context, options={})
    idx = index(self.class.context_to_sym(context))
    raise "#{context} is not in the hierarchy, which has the following levels: #{self.inspect}" unless idx
    parent = idx <= 0 ? nil : self[idx-1]
    return nil unless parent
    options[:as] == :symbol ? parent : parent.to_s.classify.constantize
  end

  def self.context_to_sym(context)
    case context
      when Symbol then context
      when Class then context.name.underscore.to_sym
      when String then context.underscore.to_sym
      else context.class.name.underscore.to_sym
    end
  end
end