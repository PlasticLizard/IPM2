class OrganizationalUnit < AccountModel
  acts_as_tree
  belongs_to :account 

end