class OrganizationalUnit < ActiveRecord::Base
  include AccountModel
  acts_as_tree

  def child_type
    @child_type ||= Account.current.organizational_structure.child_of(self)
  end

  def create_child!(attributes={})
    attributes[:parent] = self
    new_ou = child_type.new(attributes)
    new_ou.save!
    new_ou
  end
end