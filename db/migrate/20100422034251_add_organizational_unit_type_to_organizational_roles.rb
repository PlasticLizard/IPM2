class AddOrganizationalUnitTypeToOrganizationalRoles < ActiveRecord::Migration
  def self.up
    add_column :organizational_roles, :organizational_unit_type, :string
    add_column :organizational_role, :position_type, :string
  end

  def self.down
    remove_column :organizational_roles, :organizational_unit_type
    remove_column :orgnizational_roles, :position_type
  end
end
