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

  def run
    welcome
    login
    # movie
    # wanna_see_favs?
    # get_joke(what_subject)
  end

  private

  def welcome
    puts "Hi, Welcome to Radion Movie Theater"
  end

  def login
    movies_array = Movie.all.map{|movie| movie.movie_name}
    movie_prompt = TTY::Prompt.new
    movie_option = movie_prompt.select("Please select your movie:", [movies_array])
    
    theaters_array = Theater.all.map {|theater| theater.theater_name}
    theater_prompt = TTY::Prompt.new
    theater_option = theater_prompt.select("Please select the movie theater:", [theaters_array])

    showtime_array = Showtime.all.map {|showtime| showtime.movie_time}
    showtime_prompt = TTY::Prompt.new
    # showtime_array.uniq!
    showtime_option = showtime_prompt.select("Please select your time:", [showtime_array])
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





