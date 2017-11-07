class Model
  def self.models
    JSON.parse(File.read("./db/#{table_name}.json"))
  end

  def self.all
    models = self.models.map do |item|
      self.new(item['id'])
    end
    return models
  end

  def self.where (field_name, value)
    _models = self.models.select do |item|
      item[field_name] == value
    end

    models = _models.map do |item|
      self.new(item['id'])
    end

    return models
  end

  def self.get_by_id(id)
    models = JSON.parse(File.read("./db/#{self.table_name}.json"))
    models.each do |item|
      if item['id'] == id
        return item
      end
    end
  end

  def save
    models = JSON.parse(File.read("./db/#{self.table_name}.json"))
    models << {
        id: model.last['id']+=1,
        title: @title,
        author: @author
    }
    File.write("./db/#{self.table_name}.json", JSON.generate(models))
  end

  def delete
    models = JSON.parse(File.read("./db/#{self.table_name}.json"))
    models.delete_if { |h| h['id'] == @id }
    File.write("./db/#{self.table_name}.json", JSON.generate(models))
  end

  def self.last
    JSON.parse(File.read("./db/#{self.table_name}.json")).last
  end

end