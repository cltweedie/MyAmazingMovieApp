# Helper methods defined here can be accessed in any controller or view in the application

module MyAmazingMovieApp
  class App
    module MovieHelper
      # def simple_helper_method
      # ...
      # end
    end

    helpers MovieHelper
    layout :layout
  end
end
