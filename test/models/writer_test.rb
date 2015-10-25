require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Writer Model" do
  before do
    mock_data = JSON(File.read('test/jaws.json'))
    HTTParty.expects(:get).returns(mock_data)

    @movie = Movie.get_film_info('Jaws')
  end

  it "Adds each writer from a movie to the writers table" do

    Writer.count.must_equal 2
    Writer.first.name.must_equal "Peter Benchley"
  end

  it "knows which writers the movie has" do
    @movie.writers.first.name.must_equal "Peter Benchley"
  end
end
