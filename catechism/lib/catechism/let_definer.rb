class Catechism::LetDefiner < Struct.new(:context)
  def define_let(name, let_block)
    it_block = context
    it_block.define_singleton_method(name) do
      instance_variable_name = :"@#{name}"
      if instance_variable_defined?(instance_variable_name)
        instance_variable_get(instance_variable_name)
      else
        instance_variable_set(instance_variable_name, it_block.instance_eval(&let_block))
      end
    end
  end
end