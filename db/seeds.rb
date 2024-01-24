# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# require "json"
# require "open-uri"


# url = "https://tmdb.lewagon.com/movie/top_rated"
# movie_list_serialized = URI.open(url).read
# movie_list = JSON.parse(movie_list_serialized)


# 15.times do |i|
#   Movie.create(title: movie_list['results'][i]['title'], overview: movie_list['results'][i]['overview'],
#   poster_url: "#{url}#{movie_list['results'][i]['poster_path']}", rating: movie_list['results'][i]['vote_average'])
# end

# puts "db successed!"

# require 'json'
# require 'open-uri'

# puts "starting..."

# url = URI("https://api.themoviedb.org/3/movie/550?api_key=a1b2d74ae9b3e216671e11ebc591acc4")
# movies_json = Net::HTTP.get(url)
# movies = JSON.parse(movies_json)

# 50.times do |i|
#   Movie.create(
#     title: movies['results'][i]['title'],
#     overview: movies['results'][i]['overview'],
#     poster_url: "https://image.tmdb.org/t/p/w500#{movies["results"][i]["poster_path"]}",
#     rating: movies['results'][i]['vote_average']
#     )
# end

# require 'json'
# require 'net/http'

# puts "starting..."
# # Fetch data from the API
# # Correct URL for popular movies
# url = URI("https://api.themoviedb.org/3/movie/popular?api_key=a1b2d74ae9b3e216671e11ebc591acc4")
# movies_json = Net::HTTP.get(url)
# movies = JSON.parse(movies_json)

# puts "creating lists..."
# # Create lists
# lists = ['movies to cry', 'directed by women', 'comfort movies', 'forgotten gems', 'sleep w/ lights on', 'life-changing']
# lists.each do |list_name|
#   List.create!(name: list_name)
# end

# puts "creating movies..."
# # Create movies and bookmarks
# movies["results"].each do |movie|
#   # Check if overview is present
#   if movie["overview"].present?
#     created_movie = Movie.create!(
#       title: movie["title"],
#       overview: movie["overview"],
#       poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}",
#       rating: movie["vote_average"]
#     )

#     # Create a bookmark for each movie in each list
#     List.all.each do |list|
#       Bookmark.create!(
#         comment: "This is a comment.",
#         movie: created_movie,
#         list: list
#       )
#     end
#     puts "created successfully!"
#   else
#     puts "Skipped movie creation due to missing overview."
#   end
# end

require 'json'
require 'net/http'

puts "starting..."
# Fetch data from the API
# Correct URL for popular movies
url = URI("https://api.themoviedb.org/3/movie/popular?api_key=a1b2d74ae9b3e216671e11ebc591acc4")
movies_json = Net::HTTP.get(url)
movies = JSON.parse(movies_json)

puts "creating lists..."
# Create lists
lists = ['movies to cry', 'directed by women', 'comfort movies', 'forgotten gems', 'sleep w/ lights on', 'life-changing']
lists.each do |list_name|
  List.create!(name: list_name)
end

puts "creating movies..."
# Create movies and bookmarks for the first 50 results
movies["results"].take(50).each do |movie|
  # Check if overview is present for each movie
  if movie["overview"].present?
    created_movie = Movie.create!(
      title: movie["title"],
      overview: movie["overview"],
      poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}",
      rating: movie["vote_average"]
    )
    
    puts "created successfully!"
  else
    puts "Skipped movie creation due to missing overview."
  end
end
