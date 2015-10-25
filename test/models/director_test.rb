require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Director Model" do
  it "knows which movies belong to which director" do
    mock_data = JSON(File.read('test/jaws.json'))
    HTTParty.expects(:get).returns(mock_data)

    movie = Movie.get_film_info('Jaws')

    movie.director.name.must_equal "Steven Spielberg"
  end
end
