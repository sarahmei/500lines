require "catechism/it_block"
require "catechism/let_definer"

class Catechism::DescribeBlock < Struct.new(:description, :block)
  def before(&before_block)
    before_blocks << before_block if block_given?
  end

  def after(&after_block)
    after_blocks << after_block if block_given?
  end

  def call
    instance_eval(&block)
  end

  def it(description, &block)
    it_block = Catechism::ItBlock.new(description, self)
    let_definer = Catechism::LetDefiner.new(it_block)
    let_blocks.each { |name, let_block| let_definer.define_let(name, let_block) }
    before_blocks.each { |before_block| it_block.instance_eval(&before_block) }
    it_block.instance_eval(&block) if block_given?
    after_blocks.each { |after_block| it_block.instance_eval(&after_block) }
  end

  def let(name, &let_block)
    let_blocks[name] = let_block
  end

  def it_blocks
    @it_blocks ||= []
  end

  def let_blocks
    @let_blocks ||= {}
  end

  def before_blocks
    @before_blocks ||= []
  end

  def after_blocks
    @after_blocks ||= []
  end
end
