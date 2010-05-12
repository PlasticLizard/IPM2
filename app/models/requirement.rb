class Requirement
  include MongoMapper::EmbeddedDocument

  key :name, String
  
end