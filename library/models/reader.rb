class Reader < Model
  attr_accessor :id, :name, :email, :city, :street, :house, :table_name
  @@table_name = 'readers'

  def initialize (id = nil, fields = nil)
    model = fields ? fields : self.class.get_by_id(id)
    @id = id || self.class.last['id']
    @name = model['name']
    @email = model['email']
    @city = model['city']
    @street = model['street']
    @house = model['house']
  end

  def self.table_name
    @@table_name
  end

  def self.often_take_book(title)
    book = Book.where('title', title).first
    orders = Order.where('book', book.id).group_by { |d| d.reader }
    max = orders.max_by do |item|
      item.length
    end

    "#{Reader::where('id', max[0]).first.name} took \"#{title}\" #{max[1].length} times"
  end
end