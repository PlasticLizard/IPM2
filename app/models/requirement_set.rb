class RequirementSet < AccountModel

  key :name, String
  key :description, String

  key :organizational_unit_ids, Array
  many :organizational_units, :in=>:organizational_unit_ids
  
  key :department_id, ObjectId
  belongs_to :department

  key :type, String

  many :requirements, :polymorphic=>true


end