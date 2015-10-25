class Director < ActiveRecord::Base

  has_many :movies

  def self.get_director(data)
    d = Director.new
    d.name = data["Director"]
    d.save!
  end

end
