class Radion
  # here will be your CLI!
  # it is not an AR class so you need to add attr

# - Welcome user
# - Show list of movies
# - Select a movie
# - Show list of showtime
# - Select a time
# - Show list of available seats
# - Select a seat
# - Ask user for login/sign up(input)

# Return customer ticket with:
# - Customer name
# - Movie title
# - Showtime
# - Seat

  attr_accessor :name

  require "tty-prompt"

  $prompt = TTY::Prompt.new

  def run
    welcome
    login
    movie
    # wanna_see_favs?
    # get_joke(what_subject)
  end

  private

  def welcome
    puts "Hi, Welcome to Radion"
  end

  def login
    movies = Movie.all.each do |movie|
      # binding.pry
      " #{movie.id}- #{movie.movie_name} - #{movie.producer}"
    end
    option = $prompt.select("Please choose your movie:", ["movies".capitalize, "My Tickets"])
      option
  end

  # def login
  #   puts "what is your name ?"
  #   name = gets.chomp.downcase
    
  #   @name = Customer.find_or_create_by(name: name.capitalize)
  #   puts "Welcome #{@name.name.capitalize}!"
  #   # binding.pry
  # end

  # def movie
  #   puts "Available movies today:"
  #   Movie.all.each do |movie|
  #     # binding.pry
  #     puts " #{movie.id}- #{movie.movie_name} - #{movie.producer}"
  #     puts " "
  #   end
  # end

end #end of class





