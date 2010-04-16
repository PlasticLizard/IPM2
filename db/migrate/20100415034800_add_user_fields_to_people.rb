class AddUserFieldsToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :email_address, :string
    add_column :people, :last_access, :timestamp
  end

  def self.down
    remove_column :people, :email_address
    remove_column :people, :last_access
  end
end
