class Movie < ActiveRecord::Base

  def self.get_film_info(title)
    imdb_data = HTTParty.get("http://www.omdbapi.com/?t=#{title}")

    m = Movie.create!(title: imdb_data["Title"])
  end

end
