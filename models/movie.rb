class Movie < ActiveRecord::Base

  belongs_to :director

  has_many :actor_movies
  has_many :actors, :through => :actor_movies

  has_many :movie_writers
  has_many :writers, :through => :movie_writers

  has_many :movie_genres
  has_many :genres, :through => :movie_genres

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
    m.director = Director.create!(name: imdb_data["Director"])
    actors = Actor.get_actors(imdb_data)
    actors.each { |a| m.actors << Actor.find_or_create_by(name: a) }
    writers = Writer.get_writers(imdb_data)
    writers.each do |w|
      writer = Writer.find_or_create_by(name: w)
      unless m.writers.include? writer
        m.writers << writer
      end
    end
    genres = Genre.get_genres(imdb_data)
    genres.each { |g| m.genres << Genre.find_or_create_by(name: g) }
    m.save!
    m
  end

  protected
  def set_slug
    self.slug = self.title.chomp.strip.downcase.gsub(" ", "-")
  end
end
