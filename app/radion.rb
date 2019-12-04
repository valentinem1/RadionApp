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
    # login
    # movie
    # wanna_see_favs?
    # get_joke(what_subject)
  end

  private

  def welcome
    puts "Hi, Welcome to Radion Movie Theater"

    puts "What is your name ?"
    user = gets.chomp.downcase
    user_instance = Customer.find_or_create_by(name: user)
    # binding.pry
    login(user_instance)
  end

  def login(user_instance)
    movies_array = Movie.all.map{|movie| movie.movie_name}
    movies_array.uniq!
    movie_prompt = TTY::Prompt.new
    movie_option = movie_prompt.select("Please select your movie:", [movies_array])
    
    theaters_array = Theater.all.map {|theater| theater.theater_name}
    theaters_array.uniq!
    theater_prompt = TTY::Prompt.new
    theater_option = theater_prompt.select("Please select the movie theater:", [theaters_array])

    showtime_array = Showtime.all.map {|showtime| showtime.movie_time}
    showtime_prompt = TTY::Prompt.new
    showtime_array.uniq!
    showtime_option = showtime_prompt.select("Please select your time:", [showtime_array])

    ticket_processor(movie_option,theater_option,showtime_option,user_instance)
  end


  def ticket_processor(movie_option,theater_option,showtime_option,user_instance)
    movie_instance = Movie.find_by(movie_name:movie_option)
    theater_instance = Theater.find_by(theater_name:theater_option)
    ticket_instance = Ticket.create(customer_id: user_instance.id,theater_id: theater_instance.id,movie_id: movie_instance.id)
    ticket_printer(ticket_instance)
  end
  def ticket_printer(ticket_instance)
    
    puts "          ___________
          |    #{ticket_instance.id}   |
          |         |
          |    #{ticket_instance.customer_id}   |
          |         |
          |    #{ticket_instance.theater_id}   |
          |         |
          |_________|"
  end

end #end of class





