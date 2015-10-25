class RemoveMovieIdFromActors < ActiveRecord::Migration

  def self.up
    change_table :actors do |t|
      t.remove :movie_id
    end
  end

  def self.down
    change_table :actors do |t|
      t.integer :movie_id
    end
  end

end
