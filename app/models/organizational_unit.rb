class OrganizationalUnit < AccountModel
  include MongoMapper::Acts::Tree

  key :name, String
  key :_type, String

  acts_as_tree
  
  def child_type
    @child_type ||= account.organizational_structure.child_of(self)
  end

  def create_child!(attributes={})
    attributes[:parent] = self
    new_ou = child_type.new(attributes)
    new_ou.save!
    new_ou
  end

  def roles
    account.roles.
            find_all_by_organizational_unit_type(self.class.organizational_unit_type.to_s)
  end

  def self.organizational_unit_type
    OrganizationalUnitHierarchy.context_to_sym(self)
  end
end