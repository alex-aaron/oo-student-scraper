require 'open-uri'
require 'nokogiri'
require 'pry'

input_url = "https://www.afi.com/afis-100-years-100-movies-10th-anniversary-edition/"

def self.scrape_profile_page(input_url)
    html = open(input_url)
    afi = Nokogiri::HTML(html) 
    movies = afi.css("div. single-list h6")
    binding.pry

  end

  scrape_profile_page(input_url)