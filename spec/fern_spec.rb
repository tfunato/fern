require 'spec_helper'

describe Fern do
  it 'should have a version number' do
    expect(Fern::VERSION).not_to be_empty
  end

  it 'should do something useful' do
    expect(Fern.make_fern).not_to be_empty
  end
end
