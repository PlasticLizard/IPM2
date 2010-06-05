class CredentialGroup
  include MongoMapper::EmbeddedDocument

  key :operator, Symbol, :default=>:all
  def self.operators; [:all, :any]; end

  key :required_credential_ids, Array
  many :required_credentials, :in=>:required_credential_ids, :class_name=>'Credential'

  def name
    "#{operator.to_s.titleize} required"
  end

end