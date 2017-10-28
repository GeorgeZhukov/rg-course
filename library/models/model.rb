
class Model
  def initialize(id)

  end

  def self.all()
    _books = JSON.parse(File.read("./db/#{self.table_name}.json"))
    books = _books.map do |item|
      self.new(item['id'])
    end
    return books
  end

  def self.all_array()
    JSON.parse(File.read("./db/#{self.table_name}.json"))
  end

  def self.where (field_name, value)
    _books = JSON.parse(File.read("./db/#{self.table_name}.json"))
    _books = _books.select do |item|
      item[field_name] == value
    end

    books = _books.map do |item|
      self.new(item['id'])
    end

    return books
  end

  def self.where_array (field_name, value)
    _books = JSON.parse(File.read("./db/#{self.table_name}.json"))
    books = _books.select do |item|
      item[field_name] == value
    end

    return books
  end

  def self.get_by_id(id)
    books = JSON.parse(File.read("./db/#{self.table_name}.json"))
    books.each do |item|
      if item['id'] == id
        return item
      end
    end
  end

  def save ()
    books = JSON.parse(File.read("./db/#{self.table_name}.json"))
    books << {
        id: Book.last['id']+=1,
        title: @title,
        author: @author
    }
    File.write("./db/#{self.table_name}.json", JSON.generate(books))
  end

  def delete()
    books = JSON.parse(File.read("./db/#{self.table_name}.json"))
    books.delete_if { |h| h['id'] == @id }
    File.write("./db/#{self.table_name}.json", JSON.generate(books))
  end

  def self.last()
    JSON.parse(File.read("./db/#{self.table_name}.json")).last
  end

end