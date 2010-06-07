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

  many :credentials, :dependent=>:destroy

  many :roles, :class_name=>'OrganizationalRole', :dependent=>:destroy
  many :departments, :dependent=>:destroy, :order=>'position' do
    def reorder(ordered_department_ids)
      all.each do |dep|
        dep.position = ordered_department_ids.index(dep.id.to_s) + 1
        dep.save
      end
    end
  end

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

end