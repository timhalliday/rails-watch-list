# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

url = 'http://tmdb.lewagon.com/movie/top_rated'
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)

Movie.destroy_all
puts 'Generating movies'

movies['results'].each do |movie|
  new_movie = Movie.new(
                        title: movie['title'],
                        overview: movie['overview'],
                        poster_url: 'https://image.tmdb.org/t/p/w500/' + movie['poster_path'],
                        rating: movie['vote_average']
                       )
  puts new_movie['title']
  new_movie.save
end
