class Movie < ActiveRecord::Base
    @all_ratings = ["G","PG","PG-13","R"]
    def self.with_ratings(ratings_list)
      Movie.where(rating:ratings_list)
    end
    
    def self.all_ratings
      @all_ratings
    end 
end