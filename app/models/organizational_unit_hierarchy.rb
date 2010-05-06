class OrganizationalUnitHierarchy < Array
  def initialize(*args)
    unless args.empty?
      super(args[0].kind_of?(Array) ? args[0] : args)
      self.map!{|type|self.class.context_to_sym(type)}
    end
  end

  def child_of(context)
   idx = index(self.class.context_to_sym(context))
   raise "#{context} is not in the hierarchy, which has the following levels: #{self.inspect}" unless idx
   idx >= length-1 ? nil : self[idx+1].to_s.classify.constantize
  end

  def parent_of(context)
    idx = index(self.class.context_to_sym(context))
    raise "#{context} is not in the hierarchy, which has the following levels: #{self.inspect}" unless idx
    idx <= 0 ? nil : self[idx-1].to_s.classify.constantize
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