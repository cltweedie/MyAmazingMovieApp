class ChangeActorsTableToHaveOneName < ActiveRecord::Migration
  def self.up
    remove_column :actors, :first_name
    remove_column :actors, :last_name
    add_column :actors, :name, :string
  end

  def self.down
    add_column :actors, :first_name, :string
    add_column :actors, :last_name, :string
    remove_column :actors, :name
  end
end
