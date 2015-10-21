MyAmazingMovieApp::App.controllers :movies do

  get '/:slug' do
    @movie = Movie.find_by(slug: params[:slug])
    if @movie
      render 'movie/show'
    else
      404
    end
  end

end
