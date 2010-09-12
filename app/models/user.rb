class User < AccountModel
  devise  :database_authenticatable, :token_authenticatable, :rememberable, :validatable, :recoverable #,:trackable, :lockable, :registerable

  attr_accessible :email, :password, :password_confirmation, :account_id, :account, :full_name

  key :full_name, String
  key :first_name, String
  key :last_name, String
  key :_type, String

  def full_name_formal
    "#{last_name}, #{first_name}"
  end

  before_save :parse_name
  def parse_name
    if full_name.blank?
      self.first_name = nil
      self.last_name = nil
    elsif (pieces = full_name.split(",")).length > 1
      self.last_name = pieces[0].split(" ").map{|p|p.strip}.join(" ")
      self.first_name = pieces[1].strip
    else
      pieces = full_name.split(" ")
      self.first_name = pieces.shift.strip
      self.last_name =  pieces.map{|p|p.strip}.join(" ")
    end
  end
end
