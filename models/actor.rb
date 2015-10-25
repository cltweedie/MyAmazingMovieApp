class Actor < ActiveRecord::Base

  has_many :actor_movies
  has_many :movies, :through => :actor_movies

  def self.get_actors(data)
    data["Actors"].split(",").map { |a| a.strip }
  end

  def format_movies
    movs = ""
    if self.movies.length > 1
      self.movies.each do |m|
        movs << m.title
        movs << ", "
      end
      movs = movs[0, movs.length-2]
    else
      movs = self.movies.first.title
    end
    movs
  end

end
