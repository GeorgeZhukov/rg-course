class Book < Model
  attr_accessor :id, :author, :title, :table_name

  def initialize (id = nil, fields = nil)
    model = fields ? fields : self.class.get_by_id(id)
    @id = id || self.class.last['id']
    @title = model['title']
    @author = model['author']
  end

  def self.table_name
    'books'
  end

end