class Account
  include MongoMapper::Document

  key :name, String
  timestamps!

  many :requirement_sets do
    def global
      all.select{|rs|rs.department_id.blank?}
    end
  end

  many :companies, :dependent=>:destroy do
    def arrange
      TreeHelper.arrange_tree_nodes(all)
    end
  end

  many :credentials, :dependent=>:destory do
    def by_department_and_type
      proxy_owner.create_departmental_credential_hierarchy(all)
    end
  end


  many :roles, :class_name=>'OrganizationalRole', :dependent=>:destroy
  many :departments, :dependent=>:destroy, :order=>'name'

  many :employees, :dependent=>:destroy, :order=>'last_name, first_name'

  def organizational_structure
    @organizational_structure ||= OrganizationalUnitHierarchy.new(Company,Region,Station,TransportUnit)
  end

  def organizational_units
    OrganizationalUnit.all :account_id=>id, :order=>'path'
  end

  def organizational_model
    TreeHelper.arrange_tree_nodes(organizational_units)
  end

  after_save :ensure_company
  def ensure_company
    unless companies.size > 0
      companies.build :name=>self.name
      save!
    end
  end

  cattr_accessor :current
  def self.set_current_account(account=nil)
    @@current = account
  end
  def self.clear_current_account()
    @@current = nil
  end

  def create_departmental_credential_hierarchy(credentials)
    hierarchy = OrderedHash.new
    by_department = credentials.group_by{|cred|cred.department_id}
    departments.each do |department|
      by_type = by_department[department.id]
      by_type = by_type.group_by{|cred|cred.type} if by_type
      types = OrderedHash.new
      Credential.credential_types.each do |type|
        types[type] = by_type ? by_type[type] : []
      end
      hierarchy[department] = by_type#types
    end
    hierarchy
  end
end
