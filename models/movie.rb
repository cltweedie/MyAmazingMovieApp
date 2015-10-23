class Movie < ActiveRecord::Base

  validates :title, presence: true

  before_save :set_slug

  def self.slugify(title)
    title.squeeze.strip.downcase.gsub(" ", "-")
  end

  def self.get_film_info(title)
    imdb_data = HTTParty.get("http://www.omdbapi.com/?t=#{title}")

    m = Movie.new(title: imdb_data["Title"],
                      poster: imdb_data["Poster"],
                      year: imdb_data["Year"],
                      runtime: imdb_data["Runtime"],
                      description: imdb_data["Plot"]
      )
    m.save!
    m
  end

  protected
  def set_slug
    self.slug = self.title.chomp.strip.downcase.gsub(" ", "-")
  end
end
