Movie.destroy_all
Theater.destroy_all
Showtime.destroy_all
Ticket.destroy_all
Customer.destroy_all
10.times do 
    # binding.pry
    Movie.create(movie_name: Faker::Game.title, producer: Faker::FunnyName.name, rating: rand(1..5))
end

10.times do 
    # binding.pry
    Theater.create(theater_name: "#{Faker::Name.initials} Theater", location: Faker::Space.planet)
end

10.times do
    Customer.create(name: Faker::Name.name)
end

5.times do
    Showtime.create(movie_time: Faker::Time.between(from: DateTime.now , to: DateTime.now + 5, format: :short))
    # binding.pry
end
