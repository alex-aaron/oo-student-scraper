require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

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
        movie_hash[detail_array[0].downcase.strip.to_sym] = detail_array[1]
      end
      movie_hash_array << movie_hash
    end
    movie_hash_array
    binding.pry
  end






  # def self.scrape_index_page(index_url)
  #   html = open(index_url)
  #   doc = Nokogiri::HTML(html) 

  #   student_array = []

  #   doc.css("div.student-card").each do |students|
  #     student_hash = {
  #       :name => students.css("h4.student-name").text,
  #       :location => students.css("p.student-location").text,
  #       :profile_url => students.css("a").attribute("href").value
  #     }
  #     student_array << student_hash
  #   end
  #   student_array
  # end

  # def self.scrape_profile_page(profile_url)
  #   html = open(profile_url)
  #   profile_page = Nokogiri::HTML(html) 
  #   social_array = profile_page.css("div.social-icon-container a")

  #   student_attributes = {}

  #   social_array.each do |social_media|
  #     if social_media.attribute("href").value.include?("twitter")
  #       student_attributes[:twitter] = social_media.attribute("href").value
  #     elsif social_media.attribute("href").value.include?("linkedin")
  #       student_attributes[:linkedin] = social_media.attribute("href").value
  #     elsif social_media.attribute("href").value.include?("github")
  #       student_attributes[:github] = social_media.attribute("href").value
  #     else
  #       student_attributes[:blog] = social_media.attribute("href").value
  #     end
  #   end

  #   student_attributes[:profile_quote] = profile_page.css("div.profile-quote").text

  #   student_attributes[:bio] = profile_page.css("div.description-holder p").text

  #   # student_attributes = {
  #   #   :twitter => social_array[0].attribute("href").value,
  #   #   :linkedin => social_array[1].attribute("href").value,
  #   #   :github => social_array[2].attribute("href").value,
  #   #   :blog => social_array[3].attribute("href").value,
  #   #   :profile_quote => profile_page.css("div.profile-quote").text,
  #   #   :bio => profile_page.css("div.description-holder p").text
  #   # }
  #   student_attributes
  # end

  # def scraper_test
  #   input_url = "https://www.afi.com/afis-100-years-100-movies-10th-anniversary-edition/"
  #   html = open(input_url)
  #   afi = Nokogiri::HTML(html) 
  #   movies = afi.css("div. row h6")
  # end

end

