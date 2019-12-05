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
    menu = ["Buy a movie","My tickets","Exit"]
    menu_prompt = TTY::Prompt.new
    menu_option = menu_prompt.select("Please select your option:", [menu])
    if menu_option == "Buy a movie"
      movie_selector
    elsif menu_option == "Exit"
      exit
    elsif menu_option == "My tickets"
      my_tickets
    end
  end

  def movie_selector
    movies_array = Movie.all.map{|movie| movie.movie_name}
    movies_array.uniq!
    movie_prompt = TTY::Prompt.new
    @movie_selection = movie_prompt.select("Please select your movie:", [movies_array,"Main menu"])
    if @movie_selection == "Main menu"
      menu
    end
    theater_selector
  end

  def theater_selector
    theaters_array = Theater.all.map {|theater| theater.theater_name}
    theaters_array.uniq!
    theater_prompt = TTY::Prompt.new
    @theater_selection = theater_prompt.select("Please select the movie theater:", [theaters_array,"Go back","Main menu"])
    if @theater_selection == "Go back"
      movie_selector
    elsif @theater_selection == "Main menu"
      menu
    end
    showtime_selector
  end

  def showtime_selector
    showtime_array = Showtime.all.map {|showtime| showtime.movie_time}
    showtime_prompt = TTY::Prompt.new
    showtime_array.uniq!
    @showtime_selection = showtime_prompt.select("Please select your time:", [showtime_array,"Go back","Main menu"])
    if @showtime_selection == "Go back"
      theater_selector
    elsif @showtime_selection == "Main menu"
      menu
    end
    ticket_creator(@movie_selection,@theater_selection,@showtime_selection)
  end
  
  def ticket_creator(movie_selection,theater_selection,showtime_selection)
    @movie_instance = Movie.find_by(movie_name:@movie_selection)
    @theater_instance = Theater.find_by(theater_name:@theater_selection)
    @showtime_instance = Showtime.find_by(movie_time:@showtime_selection)
    @ticket_instance = Ticket.create(customer_id: @user_instance.id,theater_id: @theater_instance.id,movie_id: @movie_instance.id, showtime_id: @showtime_instance.id)
    ticket_printer(@ticket_instance,@movie_instance,@theater_instance)
  end

  #after buying a ticket method
  def ticket_printer(ticket_instance,movie_instance,theater_instance)
    system 'clear'
    logo_displayer
    table_data = [
      {:ticketnumber.capitalize => ticket_instance.id,
      :name.capitalize => @user_instance.name.capitalize,
      :movie.capitalize => @movie_instance.movie_name,
      :theater.capitalize => @theater_instance.theater_name,
      :showtime.capitalize => @showtime_instance.movie_time}
    ]
    Formatador.display_table(table_data)
    post_buying_option
  end

  #user tickets list
  def my_tickets
    system "clear"
    logo_displayer
    @customer_tickets = Ticket.all.select{|ticket|ticket.customer_id == @user_instance.id}
    
    if @customer_tickets == []
      puts "No ticket found"
      sleep (2)
      menu
    end
    ticket_array = @customer_tickets.each do |ticket|
      ticket_table = [
        {:ticketnumber.capitalize => ticket.id,
        :name.capitalize => (Customer.find_by(id: ticket.customer_id)).name,
        :movie.capitalize => (Movie.find_by(id: ticket.movie_id)).movie_name,
        :theater.capitalize => (Theater.find_by(id: ticket.theater_id)).theater_name,
        :showtime.capitalize => (Showtime.find_by(id: ticket.showtime_id)).movie_time}
      ]
        Formatador.display_table(ticket_table)  
      end
      update
  end

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
        exit
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
        logo_displayer
        menu
      elsif update_option == "Change ticket"
        change_ticket
        menu
      elsif update_option == "Main menu"
        menu 
      elsif update_option == "Exit"
        exit
      end
    end
    
    def change_ticket
      ticket_id_array = @customer_tickets.map{|ticket|
      ticket.id}
      ticket_prompt = TTY::Prompt.new
      ticket_option = ticket_prompt.select("Select a ticket", ticket_id_array)
      @ticket_instance = Ticket.find_by(id:ticket_option)

      @ticket_instance.destroy
      puts "Ticket has been canceled. Please choose again"
      movie_selector
    end

    def exit
      puts "Thank you for shopping with us"
        sleep(2)
        TicketAnimation.animation
        exit!
    end

    def logo_displayer
      puts "
██████╗  █████╗ ██████╗ ██╗ ██████╗ ███╗   ██╗
██╔══██╗██╔══██╗██╔══██╗██║██╔═══██╗████╗  ██║
██████╔╝███████║██║  ██║██║██║   ██║██╔██╗ ██║
██╔══██╗██╔══██║██║  ██║██║██║   ██║██║╚██╗██║
██║  ██║██║  ██║██████╔╝██║╚██████╔╝██║ ╚████║
╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
      ".red

    end

  end #end of class

  
  