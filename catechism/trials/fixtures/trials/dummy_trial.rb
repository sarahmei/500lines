require 'catechism'

describe 'life' do
  it 'is a bummer' do
    expect('stuff').not.to_equal('great')
  end

  it 'is not so bad' do
    expect('tacos').to_equal('tacos')
  end
end