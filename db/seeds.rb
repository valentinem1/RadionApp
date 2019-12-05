Movie.destroy_all
Theater.destroy_all
Showtime.destroy_all
Ticket.destroy_all
Customer.destroy_all
10.times do 
    # binding.pry
    Movie.create(movie_name: Faker::Game.title)
end

10.times do 
    # binding.pry
    Theater.create(theater_name: "#{Faker::Name.initials} Theater")
end

5.times do
    Showtime.create(movie_time: Faker::Time.between(from: DateTime.now , to: DateTime.now + 5, format: :short))
    # binding.pry
end
