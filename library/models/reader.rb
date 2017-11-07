class Reader < Model
  attr_accessor :id, :name, :email, :city, :street, :house, :table_name

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
    'readers'
  end

end