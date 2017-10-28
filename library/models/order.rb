class Order < Model
  attr_accessor :id, :book, :reader, :date, :table_name
  @@table_name = 'orders'

  def initialize (id = nil, fields = nil)
    model = fields ? fields : self.class.get_by_id(id)
    @id = id || self.class.last['id']
    @book = model['book']
    @reader = model['reader']
    @date = model['date']
  end

  def self.table_name
    @@table_name
  end
end