require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Genre Model" do
  before do
    mock_data = JSON(File.read('test/jaws.json'))
    HTTParty.expects(:get).returns(mock_data)

    @movie = Movie.get_film_info('Jaws')
  end

  it "Adds each genre from a movie to the genres table" do

    Genre.count.must_equal 2
    Genre.first.name.must_equal "Drama"
  end

  it "knows which genres the movie has" do
    @movie.genres.first.name.must_equal "Drama"
    @movie.genres.count.must_equal 2
  end
end
