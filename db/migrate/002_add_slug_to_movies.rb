class AddSlugToMovies < ActiveRecord::Migration
  def self.up
    change_table :movies do |t|
      t.string :slug
    end
  end

  def self.down
    change_table :movies do |t|
      t.remove :slug
    end
  end
end
