class AddDirectorIdToMovies < ActiveRecord::Migration
  def self.up
    change_table :movies do |t|
      t.integer :director_id
    end
  end

  def self.down
    change_table :movies do |t|
      t.remove :director_id
    end
  end
end
