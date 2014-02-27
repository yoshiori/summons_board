require 'spec_helper'

describe SummonsBoard do
  it 'should have a version number' do
    SummonsBoard::VERSION.should_not be_nil
  end
end
