class AddDefaultToOrganizationalRoleRoleType < ActiveRecord::Migration
  def self.up
    remove_column :organizational_roles, :position_type
    add_column :organizational_roles, :position_type, :string, :default=>"exclusive"
  end

  def self.down
    remove_column :organizational_roles, :position_type
    add_column :organizational_roles, :position_type, :string
  end
end
