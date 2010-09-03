class User < Person
  devise  :database_authenticatable, :token_authenticatable, :rememberable, :validatable, :trackable, :recoverable #,:lockable, :registerable

  attr_accessible :email, :password, :password_confirmation, :account_id, :account, :full_name
end
