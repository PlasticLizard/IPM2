class CreateOrganizationalRoles < ActiveRecord::Migration
  def self.up
    create_table :organizational_roles do |t|
      t.string :name, :null=>false
      t.integer :account_id
      t.integer :department_id
      t.string :role_description, :limit=>500
      t.string :ancestry
      t.timestamps
    end

    add_index  :organizational_roles, :ancestry
  end

  def self.down
    drop_table :organizational_roles
  end
end
