require 'json'
require 'open-uri'

puts 'Wiping database'
Movie.destroy_all
puts 'Planting new seeds'

url = 'https://tmdb.lewagon.com/movie/top_rated'
movies_serialized = URI.parse(url).open.read
movies = JSON.parse(movies_serialized)

movies['results'].each do |movie|
  Movie.create(
    title: movie['original_title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/w1280/#{movie['poster_path']}",
    rating: movie['vote_average']
  )
  puts 'creating new movie entry'
end
