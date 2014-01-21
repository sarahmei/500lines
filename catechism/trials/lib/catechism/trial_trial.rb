require 'catechism'

describe Catechism::Trial do
  let(:trial_fixture_path) { File.expand_path('../../../fixtures/trials/dummy_trial.rb', __FILE__) }
  let(:trial) { Catechism::Trial.new(trial_fixture_path) }

  it 'runs a trial file' do
    expect { trial.run }.to_send(:puts).with("All trials passed in #{trial_fixture_path}.").to(trial)
  end

  it 'runs a trial file at a particular line' do
    expect { trial.run_at_line(9) }.to_send(:puts).with("Trial 'life is not so bad' passed.").to(trial)
  end

  it 'adds describe blocks' do
    expect(trial.describe_blocks.count).to_equal(1)
  end
end