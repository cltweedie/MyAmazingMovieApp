require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "ActorsMovies Model" do
  it 'can construct a new instance' do
    @actors_movies = ActorsMovies.new
    refute_nil @actors_movies
  end
end
