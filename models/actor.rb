class Actor < ActiveRecord::Base

  has_many :actor_movies
  has_many :movies, :through => :actor_movies

  def self.get_actors(data)
    actors = data["Actors"].split(",").map { |a| a.strip }
  end

end
