require 'pry'

MyAmazingMovieApp::App.controllers :movies do

  # COLLECTION ROUTES

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
    flash[:message] = "Movie successfully added!"
    redirect url_for(:movies, :show, slug: @movie.slug)
  end

  get :find do
    render '/movie/find'
  end

  post :find do
    movie = Movie.get_film_info(params[:title])
    flash[:message] = "We found your movie!"
    redirect url_for(:movies, :show, slug: movie.slug)
  end

  # MEMBER ROUTES

  get :show, map: '/movies/:slug' do
    @movie = Movie.find_by(slug: params[:slug])
    if @movie
      render 'movie/show'
    else
      404
    end
  end

  get :edit, :map =>"/movies/:id/edit" do
    @movie = Movie.find(params[:id])
    render 'movie/edit'
  end

  put :update, :map => '/movies/:id/update' do
    m = Movie.find(params[:id])
    m.update!(params[:movie])
    200
    flash[:message] = "Movie successfully updated"
    redirect url_for(:movies, :show, slug: m.slug)
  end

  delete :delete, :map =>"/movies/:id/delete" do
    m = Movie.find(params[:id])
    m.destroy!
    flash[:message] = "Movie successfully deleted"
    redirect url_for(:movies, :index)
  end

end
