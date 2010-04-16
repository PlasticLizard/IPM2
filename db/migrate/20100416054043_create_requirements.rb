class CreateRequirements < ActiveRecord::Migration
  def self.up
    create_table :requirements do |t|
      t.integer :account_id, :null=>false
      t.string :type
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :requirements
  end
end
