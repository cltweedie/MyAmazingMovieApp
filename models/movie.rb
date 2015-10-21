class Movie < ActiveRecord::Base

  before_save :set_slug

  def self.get_film_info(title)
    imdb_data = HTTParty.get("http://www.omdbapi.com/?t=#{title}")

    m = Movie.create!(title: imdb_data["Title"])
  end

  protected
  def set_slug
    self.slug = title.squeeze.strip.downcase.gsub(" ", "-")
  end
end
