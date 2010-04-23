class OrganizationalUnit < ActiveRecord::Base
  include AccountModel
  acts_as_tree
end