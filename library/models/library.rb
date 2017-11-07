require_relative 'model'
require_relative 'author'
require_relative 'book'
require_relative 'order'
require_relative 'reader'

# Library
class Library
  attr_reader :authors, :books, :readers, :orders

  def initialize(authors = [], books = [], readers = [], orders = [])
    @authors = authors || Author.all
    @books = books || Book.all
    @readers = readers || Reader.all
    @orders = orders || Order.all
  end

  def self.often_take_book(title)
    book = Book.where('title', title).first
    orders = Order.where('book', book.id).group_by { |d| d.reader }
    max = orders.max_by do |item|
      item.length
    end

    "#{Reader::where('id', max[0]).first.name} took \"#{title}\" #{max[1].length} times"
  end

  def self.most_popular_book
    orders = Order.all.group_by { |d| d.book }
    max = orders.max_by do |item|
      item.length
    end
    "The most popular book \"#{Book.where('id', max[0]).first.title}\". It was took #{max[1].length} times"
  end

  def self.amount_of_people_ordered_most_popular
    _orders = []
    orders = Order.all
    orders = orders.select do |item|
      unless _orders.include? item.reader
        _orders << item.reader
        true
      end
    end

    "One of the most popular book ordered #{orders.length} people"

  end

end