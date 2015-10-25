class RenameActorsMovies < ActiveRecord::Migration
  def self.up
    rename_table :actors_movies, :actor_movies
  end

  def self.down
    rename_table :actor_movies, :actors_movies
  end
end
