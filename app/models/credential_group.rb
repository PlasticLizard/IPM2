class CredentialGroup
  include MongoMapper::EmbeddedDocument

  key :rule_operator, Symbol, :default=>:all
  def self.rule_operators; [:all, :any]; end

  key :required_credential_ids, Array
  many :required_credentials, :in=>:required_credential_ids, :class_name=>'Credential'

end