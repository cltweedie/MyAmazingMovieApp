require 'pry'

MyAmazingMovieApp::App.controllers :movies do

  # COLLECTION ROUTES
  get '/' do
    render 'movie/list'
  end

  get '/new' do
    render 'movie/new'
  end

  post '/create' do
    @movie = Movie.create!(params[:movie])
    redirect "/#{@movie.slug}"
  end

  get '/:slug' do
    @movie = Movie.find_by(slug: params[:slug])
    if @movie
      render 'movie/show'
    else
      404
    end
  end

  # MEMBER ROUTES

  get '/:id/edit' do
    render 'movie/edit'
  end

  post '/:id/update' do
    m = Movie.find(params[:id])
    m.update!(params[:movie])
    200
    redirect "/#{m.slug}"
  end

  delete '/:id/delete' do
    m = Movie.find(params[:id])
    m.destroy


    redirect "/"
  end

end
