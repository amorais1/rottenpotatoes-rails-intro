class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  def index
    @all_ratings = ['G', 'PG', 'PG-13', 'R']   
    @ratings= ['G' => '1', 'PG' =>'1', 'PG-13' =>'1', 'R' => '1']
    @movies = Movie.all

  #.sort_by { |movie| movie.title}
  #movies_path= Movie.all.sort_by { |movie| movie.title}
  
    if params.has_key?(:sort)
    @movies= Movie.order(params[:sort])
    else
    @movies.where(:rating => params[:ratings].keys) if params[:ratings].present?
   # byebug
    @movies= Movie.where(:rating => params[:ratings]).order params[:sort]

   # @all_ratings = (params[:ratings].present? ? params[:ratings] : [])
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  

end


