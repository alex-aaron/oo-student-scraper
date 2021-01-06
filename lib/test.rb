require 'open-uri'
require 'nokogiri'
require 'pry'

input_url = "https://www.afi.com/afis-100-years-100-movies-10th-anniversary-edition/"

def scraper(website)

  url = Nokogiri::HTML(open(website))

  movies = url.css("div.movie_popup.single_list")

  movie_hash_array = []

  movies.each do |listing|

    movie_hash = {}

    individual_ranking = listing.css("div.m_head").text.strip.split(" ")

    rank = individual_ranking.shift.gsub('.', "").to_i

    year = individual_ranking.pop.gsub("(", "").gsub(")", "")

    title = individual_ranking.join(" ")
    
    movie_hash[:rank] = rank

    movie_hash[:title] = title

    movie_hash[:year] = year

    additional_info = listing.css("div.col-sm-6 p")

    additional_info.each do |detail|
      detail_array = detail.text.split(": ")
      movie_hash[detail_array[0].to_sym] = detail_array[1]
    end
    movie_hash_array << movie_hash
  end
  movie_hash_array
  binding.pry
end