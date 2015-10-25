class Genre < ActiveRecord::Base

  has_many :movie_genres
  has_many :movies, :through => :movie_genres

  def self.get_genres(data)
    data["Genre"].split(",").map { |g| g.strip }
  end

end
