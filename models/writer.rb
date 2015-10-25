class Writer < ActiveRecord::Base

  has_many :movie_writers
  has_many :movies, :through => :movie_writers

  def self.get_writers(data)
    data["Writer"].split(",").map { |w| w.split("(")[0].strip }
  end

end
