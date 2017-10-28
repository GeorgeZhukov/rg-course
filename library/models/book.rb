class Book < Model
  attr_accessor :id, :author, :title, :table_name

  @@table_name = 'books'

  def initialize (id = nil, fields = nil)
    model = fields ? fields : self.class.get_by_id(id)
    @id = id || self.class.last['id']
    @title = model['title']
    @author = model['author']

    @table_name = @@table_name
  end

  def self.table_name
    @@table_name
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

    max = orders.group_by { |d| d.book }.max_by do |item|
      item.length
    end

    max[0]

  end

end