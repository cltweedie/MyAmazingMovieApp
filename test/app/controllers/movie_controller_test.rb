require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe "GET to /movie/jaws" do
  describe "with a movie in the db" do
  before do
    Movie.create!(title: "Jaws")
    get "/movies/jaws"
  end

    it "should display movie information about Jaws" do
      assert last_response.ok?
      last_response.headers['Content-Type'].must_equal 'text/html;charset=utf-8'
      last_response.body.must_match "Jaws"
    end
  end

  describe "without a movie in the db" do
    before do
      get '/movies/jaws'
    end

    it "should 404" do
      assert last_response.not_found?
    end
  end
end
