require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Actor Model" do
  before do
    mock_data = JSON(File.read('test/jaws.json'))
    HTTParty.expects(:get).returns(mock_data)

    @movie = Movie.get_film_info('Jaws')
  end

  it "Adds each actor from a movie to the actors table" do

    Actor.count.must_equal 4
    Actor.first.name.must_equal "Roy Scheider"
  end

  it "knows which actors the movie has" do
    @movie.actors.first.name.must_equal "Roy Scheider"
    @movie.actors.count.must_equal 4
  end
end
