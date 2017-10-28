require 'json'
require_relative('./models/model')
require_relative ('./models/author')
require_relative ('./models/book')
require_relative ('./models/library')
require_relative ('./models/order')
require_relative ('./models/reader')

puts Reader.often_take_book('Thus Spoke Zarathustra')
puts Book.most_popular_book
puts Book.amount_of_people_ordered_most_popular