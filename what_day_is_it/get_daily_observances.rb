require 'open-uri'
require 'nokogiri'

def scrape_page(date)
p "https://en.wikipedia.org/wiki/#{date}"
doc = Nokogiri::HTML(URI.open("https://en.wikipedia.org/wiki/#{date}"))
# File.write("October_11", doc)
end

def extract_observances(date)
# stuff = Nokogiri::HTML(File.read("October_11"))

stuff = scrape_page('November_1')

#finds the list of observances (I hope there's always a feast day!) then each list item within in
list_of_observances = stuff.css('ul:contains("Christian feast day")').css('li')

observances = list_of_observances.map do |day|
    name = day.elements[0].attr('title')
    link = day.elements[0].attr('href')
    [name, link]
end

# gets rid of the eternal link to 'Calendar of Saints'
observances = observances[1..-1].to_h
end

names = extract_observances('blah').keys

def k_count(string)
    string.count('k')
end

def someone_the_something?(string)
    array = string.split
    return false unless array.length == 3

    return false unless array[1].downcase == 'the'

    true
end

def our_lady?(string)
    string.downcase.include?('our lady')
end

def international_day?(string)
    string.downcase.include?('international day')
end

def world_something_day?(string)
    array = string.split

    return false unless array.first.downcase == 'world'

    return false unless array.last.downcase == 'day'

    true
end


def funny_rating(string)
    rating = 0
    rating += k_count(string)
    rating += 1 if someone_the_something?(string)
    rating += 1 if our_lady?(string)
    rating += 1 if international_day?(string)
    rating += 1 if world_something_day?(string)
    rating
end

names.each { |name| p name, funny_rating(name) }