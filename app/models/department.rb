class Department < AccountModel

  key :name, String
  key :department_head_id, ObjectId
  key :position, Integer

  validates_presence_of :name
  validates_uniqueness_of :name, :scope=>:account_id
  
  belongs_to :department_head, :class_name=>'OrganizationalRole', :foreign_key=>'department_head_id'

  many :roles, :class_name=>'OrganizationalRole' do
    def arrange
      TreeHelper.arrange_tree_nodes(all)
    end
  end

  after_save :ensure_department_head
  def ensure_department_head
    unless roles.count > 0 || self.department_head_id
      self.roles << OrganizationalRole.new(:name=>"#{name} Director")
      self.department_head = self.roles[0]
      save!
    end
  end

  

end
