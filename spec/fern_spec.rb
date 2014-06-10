require 'spec_helper'

describe Fern do
  it 'should have a version number' do
    expect(Fern::VERSION).not_to be_empty
  end

  Fern.make_fern
end
