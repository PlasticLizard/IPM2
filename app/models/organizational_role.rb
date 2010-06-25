class OrganizationalRole < AccountModel
  include MongoMapper::Acts::Tree

  def self.position_types
    @@position_types ||= begin
      pt = BSON::OrderedHash.new
      pt[:exclusive] = "This role is assigned to a single individual"
      pt[:rotation] = "This role is divided into shifts scheduled via rotation"
      pt[:team] = "This role is shared by a team of peers"
      pt
    end
  end

  key :name, String
  key :description, String
  key :organizational_unit_type, Symbol, :default=>:company
  key :position_type, Symbol, :default=>:exclusive
  key :department_id, ObjectId

  many :employees

  acts_as_tree

  belongs_to :department
  validates_presence_of :name 

  before_save :ensure_department
  def ensure_department
    self.department_id = parent.department_id if parent && parent.department_id
  end 


end
