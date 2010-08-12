class ComplianceStatusGroup < ComplianceStatus
  include MongoMapper::EmbeddedDocument

  key :operator, Symbol, :default=>:all
  key :first_expiring_child, Date
  key :last_expiring_child, Date
  many :children, :class_name=>'ComplianceStatus', :polymorphic=>true

  def initialize(*args)
    #Detect if MM is trying to rehydrate us here
    return super if args.length > 0 && args[0].kind_of?(Hash)
    options = args.extract_options!
    super(*args)
    @operator = options[:require] || options[:operator] || :all
    #start off incomplete, to be proven wrong
    incomplete! if @operator == :any
  end

  def update_valid_until
    self.valid_until = self.operator==:all ? self.first_expiring_child : self.last_expiring_child
  end

  def << child
    #remove an existing status for the same context
    self.children.reject! {|stat|stat.context_type == child.context_type && stat.context_id == child.context_id}

    self.incomplete! if child.incomplete and operator == :all
    self.incomplete = false if !(child.incomplete) && operator == :any

    self.first_expiring_child = child.valid_until if child.valid_until &&
            (self.first_expiring_child.blank? || child.valid_until < self.first_expiring_child)

    self.last_expiring_child = child.valid_until if child.valid_until &&
            (self.last_expiring_child.blank? || child.valid_until > self.last_expiring_child)

    self.children << child
    update_valid_until
  end

  def detect_mandatory_requirements
    if self.operator == :all
      self.children.each {|child|child.mandatory = true}
    else
      last_valid_child = self.children.select{|child|(!child.incomplete) && child.valid_until == self.last_expiring_child}.pop
      unless last_valid_child
        last_valid_child = ComplianceStatus.new :operator=>:any,
                                               :name=>"Any in group",
                                               :context_id=>nil,
                                               :context_type=>nil,
                                               :incomplete=>true,
                                               :status=>:incomplete,
                                               :_type=>nil
        self.children << last_valid_child
      end
      last_valid_child.mandatory = true
    end
  end

end
