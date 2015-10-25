MyAmazingMovieApp::App.controllers :actors do

  get :create do
    201
  end

  get :index do
    render 'actors/index'
  end

  get :index, :parent => :movies do
    #find all the actors
    render 'actors/show'
    200
  end

  get :show, map: '/actors/:id' do
    @actor = Actor.find(params[:id])
    if @actor
      render 'actors/show'
    else
      404
    end
  end

  # think about when you should nest and when you shouldn't
  # it's a design decision.
  # cases where you can't have an actor without a movie id, it makes sense
  # e.g. you can't have a post without a category

  # you need foreign key for movie in actors

  # in the form_for for the movie, use f.fields_for :actors do |a|
  # in movie model set accepts_nested_attributes_for :actors

end
