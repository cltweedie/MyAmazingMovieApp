class CreateActorsMovies < ActiveRecord::Migration
  def self.up
    create_table :actors_movies do |t|
      t.integer :actor_id
      t.integer :movie_id
      t.timestamps
    end
  end

  def self.down
    drop_table :actors_movies
  end
end
