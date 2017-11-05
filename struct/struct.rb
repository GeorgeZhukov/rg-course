class Factory
  def self.new(*attributes, &block)
    Class.new do
      self.send(:attr_accessor, *attributes)

      self.send(:define_method, :initialize) do |*values|
        values.each_with_index { |val, i| self.send("#{attributes[i]}=", val) }
      end

      define_method :[] do |val|
        if val.is_a? Integer
          self.send(attributes[val])
        else
          self.send(val)
        end
      end

      def each(&block)
        instance_variables.map do |val|
          # self.instance_eval(&block)
          block.call(instance_variable_get(val))
        end
      end

      def each_pair(&block)
        instance_variables.map do |val|
          # self.instance_eval(&block)
          block.call(val.to_s.sub(/^@/, ''), instance_variable_get(val))
        end
      end

      def eql?(obj)
        return true if self == obj
        self.class == obj.class && obj.state == state
      end

      def state
        state = []
        instance_variables.map do |val|
          state << instance_variable_get(val)
        end
      end

      if block
        self.class_eval(&block)
      end
    end
  end
end

=begin
User = Factory.new :name, :address, :zip

joe = User.new('Joe Smith', '123 Maple, Anytown NC', 12345)
# => #<struct Customer name="Joe Smith", address="123 Maple, Anytown NC", zip=12345>

puts joe.name    # => "Joe Smith"
puts joe['name'] # => "Joe Smith"
puts joe[:name]  # => "Joe Smith"
puts joe[0]      # => "Joe Smith"
=end

=begin
Customer = Factory.new(:name, :address) do
  def greeting
    puts "Hello #{name}!"
  end
end

customer = Customer.new('Dave', '123 Main').greeting # => "Hello Dave!"

customer.each do |x|
  puts x
end

customer2 = Customer.new('Dave2', '123 Main')

puts customer.eql? customer2

=end
