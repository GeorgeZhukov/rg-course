require 'json'
require_relative './models/library'

puts Library.often_take_book('Thus Spoke Zarathustra')
puts Library.most_popular_book
puts Library.amount_of_people_ordered_most_popular

Library.new
