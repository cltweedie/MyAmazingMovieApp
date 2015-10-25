require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "MovieWriter Model" do
  it 'can construct a new instance' do
    @movie_writer = MovieWriter.new
    refute_nil @movie_writer
  end
end
