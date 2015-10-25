require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "MovieGenre Model" do
  it 'can construct a new instance' do
    @movie_genre = MovieGenre.new
    refute_nil @movie_genre
  end
end
