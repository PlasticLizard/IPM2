class AddPositionToDepartment < ActiveRecord::Migration
  def self.up
    add_column :departments, :position, :integer
  end

  def self.down
    remove_column :departments, :position
  end
end
