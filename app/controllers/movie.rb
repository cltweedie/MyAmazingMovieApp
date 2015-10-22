require 'pry'

MyAmazingMovieApp::App.controllers :movies do

  # COLLECTION ROUTES

  before do
    unless env['PATH_INFO'] == '/movies/login' || session[:password] == "coolbeans"
      redirect '/movies/login'
    end
  end

  get '/' do
    render 'movie/list'
  end

  get '/login' do
    render 'movie/login'
  end

  post '/login' do
    session[:password] = params[:password]
    redirect '/movies'
  end

  get '/new' do
    render 'movie/new'
  end

  post '/create' do
    @movie_details = { title: params[:title], year: params[:year],
      description: params[:description], poster: params[:poster],
      runtime: params[:runtime] }
    @movie = Movie.create!(@movie_details)
    redirect "/movies/#{@movie.slug}"
  end

  get '/find' do
    render '/movie/find'
  end

  post '/find' do
    movie = Movie.get_film_info(params[:title])
    redirect "/movies/#{movie.slug}"
  end

  get '/:slug' do
    @movie = Movie.find_by(slug: params[:slug])
    puts @movie.title
    if @movie
      render 'movie/show'
    else
      404
    end
  end

  # MEMBER ROUTES

  get '/:id/edit' do
    @movie = Movie.find(params[:id])
    render 'movie/edit'
  end

  post '/:id/update' do
    m = Movie.find(params[:id])
    m.update!(params)
    200
    redirect "/movies/#{m.slug}"
  end

  delete '/:id/delete' do
    m = Movie.find(params[:id])
    m.destroy!

    redirect "/movies"
  end

end
