require 'catechism'

describe 'who describes the describes' do
  it 'runs before blocks' do
    describe_block = Catechism::DescribeBlock.new('here is a describe')
    describe_block.before { raise 'hell' }
    expect { describe_block.it('is a good day to die') }.to_raise_error(RuntimeError)
  end

  it 'runs after blocks' do
    describe_block = Catechism::DescribeBlock.new('here is a describe')
    describe_block.after { raise 'kids' }
    expect { describe_block.it('is the future') }.to_raise_error(RuntimeError)
  end

  it 'defines let blocks' do
    describe_block = Catechism::DescribeBlock.new('here is a describe')
    describe_block.let(:explosion) { raise 'fireworks' }
    expect { describe_block.it('is shiny') { explosion } }.to_raise_error(RuntimeError)
  end

  it 'memoizes let blocks' do
    describe_block = Catechism::DescribeBlock.new('here is a describe')
    describe_block.let(:thing) { Object.new }
    describe_block.it('is the same thing') { expect(thing.object_id).to_equal(thing.object_id) }
  end
end