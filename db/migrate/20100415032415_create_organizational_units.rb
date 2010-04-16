class CreateOrganizationalUnits < ActiveRecord::Migration
  def self.up
    create_table :organizational_units do |t|
      t.string :name
      t.string :type
      t.integer :account_id, :null=>false
      t.timestamps
    end
  end

  def self.down
    drop_table :organizational_units
  end
end
