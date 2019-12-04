require_relative './models/radion_logo.rb'
class Radion
  attr_accessor :name

  require "tty-prompt"

  def run
    welcome
  end

  private

  def welcome
    system 'clear'
    Animation.animation
    logo_displayer
    puts "Hi, Welcome to Radion Movies"

    puts "What is your name ?"
    user = gets.chomp.downcase
    @user_instance = Customer.find_or_create_by(name: user)
    menu
  end

  def menu
    menu = ["Movies","My tickets","Exit"]
    menu_prompt = TTY::Prompt.new
    menu_option = menu_prompt.select("Please select your option:", [menu])
    if menu_option == "Movies"
      movie_selector
    elsif menu_option == "Exit"
      puts "Thank you for shopping with us"
      sleep(1.3)
      BananaMan.animation
      BananaMan.go
    elsif menu_option == "My tickets"
      my_tickets
    end
  end

  def movie_selector
    movies_array = Movie.all.map{|movie| movie.movie_name}
    movies_array.uniq!
    movie_prompt = TTY::Prompt.new
    @movie_option = movie_prompt.select("Please select your movie:", [movies_array,"Main menu"])
    if @movie_option == "Main menu"
      menu
    end
    theater_selector
  end

  def theater_selector
    theaters_array = Theater.all.map {|theater| theater.theater_name}
    theaters_array.uniq!
    theater_prompt = TTY::Prompt.new
    @theater_option = theater_prompt.select("Please select the movie theater:", [theaters_array,"Go back","Main menu"])
    if @theater_option == "Go back"
      movie_selector
    elsif @theater_option == "Main menu"
      menu
    end
    showtime_selector
  end

  def showtime_selector
    showtime_array = Showtime.all.map {|showtime| showtime.movie_time}
    showtime_prompt = TTY::Prompt.new
    showtime_array.uniq!
    @showtime_option = showtime_prompt.select("Please select your time:", [showtime_array,"Go back","Main menu"])
    if @showtime_option == "Go back"
      theater_selector
    elsif @showtime_option == "Main menu"
      menu
    end
    ticket_processor(@movie_option,@theater_option,@showtime_option)
  end
  
  def ticket_processor(movie_option,theater_option,showtime_option)
    @movie_instance = Movie.find_by(movie_name:@movie_option)
    @theater_instance = Theater.find_by(theater_name:@theater_option)
    @ticket_instance = Ticket.create(customer_id: @user_instance.id,theater_id: @theater_instance.id,movie_id: @movie_instance.id)
    ticket_printer(@ticket_instance,@movie_instance,@theater_instance)
  end

  #after buying a ticket method
  def ticket_printer(ticket_instance,movie_instance,theater_instance)
    system 'clear'
    logo_displayer
    table_data = [
      {:ticketnumber.capitalize=> ticket_instance.id,
      :name.capitalize => @user_instance.name.capitalize,
      :movie.capitalize => @movie_instance.movie_name,
      :theater.capitalize => @theater_instance.theater_name,
      :showtime.capitalize => @showtime_option}
    ]
    Formatador.display_table(table_data)
    post_buying_option
  end

  #tickets list
  def my_tickets
    @customer_tickets = Ticket.all.select{|ticket|ticket.customer_id == @user_instance.id}
    
    if @customer_tickets == []
      puts "No ticket found"
      sleep (3)
      menu
    end
    ticket_array = @customer_tickets.each do |ticket|
      ticket_table = [
        {:ticketnumber.capitalize=> ticket.id,
        :name.capitalize => (Customer.find_by(id: ticket.customer_id)).name,
        :movie.capitalize => (Movie.find_by(id: ticket.movie_id)).movie_name,
        :theater.capitalize => (Theater.find_by(id: ticket.theater_id)).theater_name,
        :showtime.capitalize => @showtime_option}
      ]
        Formatador.display_table(ticket_table)  
      end
      update
  end


  #prompt them for change
  #take them to another method 
  #promt for ticket number
  #find match for ticket number
  #delete ticket
  #let them buy another ticket
  def post_buying_option
    update_array = ["Cancel ticket","Main menu","Exit"]
    update_prompt = TTY::Prompt.new
    update_option = update_prompt.select("Would you like to do something else:", [update_array])
      if update_option == "Cancel ticket"
        @ticket_instance.destroy
        puts "#{@ticket_instance.id} as been canceled."
        menu
      elsif update_option == "Main menu"
        menu 
      elsif update_option == "Exit"
        puts "Thank you for shopping with us"
        sleep(2)
        BananaMan.animation
        BananaMan.go
      end
    end
  
  def update
    update_array = ["Change ticket","Cancel ticket","Main menu","Exit"]
    update_prompt = TTY::Prompt.new
    update_option = update_prompt.select("Would you like to do something else:", [update_array])
      if update_option == "Cancel ticket"
        ticket_id_array = @customer_tickets.map{|ticket|
        ticket.id}
        ticket_prompt = TTY::Prompt.new
        ticket_option = ticket_prompt.select("Select a ticket", ticket_id_array)
        @ticket_instance = Ticket.find_by(id:ticket_option)
        @ticket_instance.destroy
        puts "#{@ticket_instance.id} as been canceled."
        system "clear"
        menu
      elsif update_option == "Change ticket"
        change_ticket
      elsif update_option == "Main menu"
        menu 
      elsif update_option == "Exit"
        puts "Thank you for shopping with us"
        sleep(2)
        BananaMan.animation
        BananaMan.go
      end
    end
    
    def change_ticket
      # if @ticket_instance == nil
      ticket_id_array = @customer_tickets.map{|ticket|
      ticket.id}
      ticket_prompt = TTY::Prompt.new
      ticket_option = ticket_prompt.select("Select a ticket", ticket_id_array)
      @ticket_instance = Ticket.find_by(id:ticket_option)
      # end
      @ticket_instance.destroy
      puts "Ticket has been canceled. Please choose again"
      movie_selector
    end

    def logo_displayer
      puts "
      88888888ba                        88  88                            
      88      '8b                       88  ''                            
      88      ,8P                       88                                
      88aaaaaa8P'  ,adPPYYba,   ,adPPYb,88  88   ,adPPYba,   8b,dPPYba,   
      88''''88'            Y8  a8     `Y88  88  a8       8a  88P      8a  
      88    `8b    ,adPPPPP88  8b       88  88  8b       d8  88       88  
      88     `8b   88,    ,88   8a,   ,d88  88   8a,   ,a8   88       88  
      88      `8b    8bbdP Y8     8bbdP Y8  88     YbbdP     88       88  
      ".colorize(:red)
    end
    
    
  end #end of class
  
  
  
  
  
  