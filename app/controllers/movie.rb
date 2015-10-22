require 'pry'

# complete crud actions
# named parameters
# tests all passing
# validations
# use link_to form_tag etc in views
# use symbol notation
# flash notices for success, errors etc
# flash[:message] = "Movie added!"
# use find_or_create_by to stop duplicates

MyAmazingMovieApp::App.controllers :movies do

  # COLLECTION ROUTES

  before do
    unless session[:logged_in]
      redirect '/login'
    end
  end

  get :index do
    render 'movie/list'
  end

  get :new do
    render 'movie/new'
  end

  post :create do
    @movie_details = { title: params[:title], year: params[:year],
      description: params[:description], poster: params[:poster],
      runtime: params[:runtime] }
    @movie = Movie.create!(@movie_details)
    redirect "/movies/#{@movie.slug}"
  end

  get :find do
    render '/movie/find'
  end

  post :find do
    movie = Movie.get_film_info(params[:title])
    redirect "/movies/#{movie.slug}"
  end

  # MEMBER ROUTES

  get '/:slug' do
    @movie = Movie.find_by(slug: params[:slug])
    puts @movie.title
    if @movie
      render 'movie/show'
    else
      404
    end
  end

  # :edit, :with => :id
  get :edit, :map =>"/movies/:id/edit" do
    @movie = Movie.find(params[:id])
    render 'movie/edit'
  end

  post :update, :map =>'movies/:id/update' do
    m = Movie.find(params[:id])
    m.update!(params)
    200
    redirect "/movies/#{m.slug}"
  end

  post '/:id/delete' do
    m = Movie.find(params[:id])
    m.destroy!

    redirect "/movies"
  end

end
