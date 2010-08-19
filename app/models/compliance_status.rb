class ComplianceStatus
  include MongoMapper::EmbeddedDocument

  key :name, String, :required=>true
  key :context_id, ObjectId
  key :context_type, String
  key :valid_until, Date
  key :incomplete, Boolean, :default=>false
  key :mandatory, Boolean, :default=>false
  key :status, Symbol, :default=>:current
  key :_type, String

  alias mandatory? mandatory

  def initialize(*args)
    #Detect if MM is rehydrating form DB
    return super if args.length > 0 && args[0].kind_of?(Hash)
    name, context = args[0],args[1]
    @name = name
    @context_id = context._id if context && context.respond_to?(:_id)
    @context_type = context.class.name if context
    @valid_until = nil
    @incomplete = false
    self._type = self.class.name
  end

  def compliant?
    return [:incomplete,:expired].exclude?(status)
  end

  def days_valid
    self.valid_until ? self.valid_until - Date.today : nil
  end

  def expiration_description
    return "Never Expires" unless self.valid_until
    if days_valid > 365 then valid_until
    elsif days_valid > 60
      "#{days_valid.to_i/30} Months"
    else
      "#{days_valid} Days"
    end
  end

  def valid_until=(expire_date)
    super(expire_date)
    update_status
  end

  def incomplete=(incomplete)
    super(incomplete)
    update_status
  end

  def update_status
    @status = calculate_status
  end

  def calculate_status
    valid = days_valid
    return :incomplete if self.incomplete
    return :current if valid.blank?
    return :expired if valid < 0
    return :expiration_imminent if valid <= 7
    return :expires_soon if valid <= 30
    return :current
  end

  def incomplete!
    self.incomplete = true
  end

end
