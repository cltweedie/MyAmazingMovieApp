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

describe "GET to /movies" do
  before do
    Movie.create!(title: "Jaws")
    get '/movies'
  end

  it "should display all of the films" do
    assert last_response.ok?
    last_response.headers['Content-Type'].must_equal 'text/html;charset=utf-8'
    last_response.body.must_match "<li>Jaws</li>"
  end
end

describe "Editing a movie" do
  before do
    @movie = Movie.create!(title: "Jaws")
    get "/movies/#{@movie.id}/edit"
  end

  it "should display a form for me to edit my movie" do
    assert last_response.ok?
    last_response.headers['Content-Type'].must_equal 'text/html;charset=utf-8'
    last_response.body.must_match "<form>"
  end
end

describe "submitting my changes" do
  before do
    @movie = Movie.create!(title: "Jaws")

    post "/movies/#{@movie.id}/update", { movie: { title: "Jaws 2" } }
  end

  it "should update the movie" do
    Movie.count.must_equal 1
    @movie.reload.title.must_equal 'Jaws 2'
  end
end

describe "adding a new movie" do
  before do
    get '/movies/new'
  end

  it "shows a new form to add a movie" do
    assert last_response.ok?
    last_response.headers['Content-Type'].must_equal 'text/html;charset=utf-8'
    last_response.body.must_match "<form"
  end
end

describe "saving a movie" do

  before do
    post "/movies/create", { movie: { title: "The Matrix", year: 1999, runtime: "110 minutes" } }
  end

  it "saves the new movie to the database" do
    Movie.count.must_equal 1
    Movie.first.title.must_equal "The Matrix"
    Movie.first.year.must_equal 1999
    Movie.first.slug.must_equal "the-matrix"
  end

  it "redirects to the movie show page" do
    assert last_response.redirect?
    follow_redirect!
    last_request.path.must_equal "/the-matrix"
  end
end

describe "deleting a movie" do
  before do
    @movie = Movie.create!(title: "Dark City")
    @movie_id = @movie.id
  end

  it "finds and deletes the movie using it's ID" do
    delete "movies/#{@movie_id}/delete"

    assert_raises(ActiveRecord::RecordNotFound) do
      Movie.find(@movie_id)
    end
  end
end

# Todo: Write unit tests for creating a movie:
# 1. Create a controller action that displays a form for a new movie
# 2. Create a controller action that takes the form submission and
# creates a new movie in the databse.
