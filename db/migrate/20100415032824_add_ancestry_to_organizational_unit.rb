class AddAncestryToOrganizationalUnit < ActiveRecord::Migration
  def self.up
    add_column :organizational_units, :ancestry, :string
    add_index  :organizational_units, :ancestry
  end

  def self.down
    remove_index  :organizational_units, :ancestry
    remove_column :organizational_units, :ancestry
  end
end
