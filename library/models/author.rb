class Author < Model
  attr_accessor :id, :name, :biography, :table_name
  @@table_name = 'authors'

  def initialize (id = nil, fields = nil)
    model = fields ? fields : self.class.get_by_id(id)
    @id = id || self.class.last['id']
    @name = model['name']
    @biography = model['biography']
  end

  def self.table_name
    @@table_name
  end
end