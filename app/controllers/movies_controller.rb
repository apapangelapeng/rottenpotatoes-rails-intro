class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    checked_box = params[:ratings]
    sorted = params[:sort]||session[:sort]
    if check_boxes.nil?:
      @ratings_to_show = []
    else:
      @ratings_to_show = check_boxes.keys
    end

    if check_boxes.nil?:
      @movies = Movie.all
    else:
      @movies = Movie.with_ratings(@ratings_to_show)
    end
    @movies = movies.order(sorted)
    @all_ratings = Movie.all_ratings
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

  class Movie < ActiveRecord::Base
    @all_rating = ["G","PG","PG-13","R","NC-17"]
    def self.with_ratings(ratings_list)
      Movie.where(rating:rating_list)
    end
     
   def self.all_ratings 
     @all_ratings
   end 
 end
  
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
