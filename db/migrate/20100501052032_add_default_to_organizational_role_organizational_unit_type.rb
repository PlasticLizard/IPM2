class AddDefaultToOrganizationalRoleOrganizationalUnitType < ActiveRecord::Migration
  def self.up
    remove_column :organizational_roles, :organizational_unit_type
    add_column :organizational_roles, :organizational_unit_type, :string, :default=>"company"
  end

  def self.down
    remove_column :organizational_roles, :organizational_unit_type
    add_column :organizational_roles, :organizational_unit_type, :string
  end
end
