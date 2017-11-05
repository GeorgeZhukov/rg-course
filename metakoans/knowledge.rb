class Module
  def attribute(properties, &block)
    properties = {"#{properties}": nil} if properties.class == String

    properties.each do |name, default|
      variable = "@#{name}"

      define_method "#{name}" do
        if instance_variables.include? variable.to_sym
          instance_variable_get variable
        else
          block ? instance_eval(&block) : default
        end
      end

      define_method("#{name}=") { |value| instance_variable_set variable, value }
      define_method("#{name}?") { not eval(name.to_s).nil? }
    end
  end
end