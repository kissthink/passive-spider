require 'spec_helper'

describe '.LibHelper' do

	before :all do
		@helper = LibHelper.new
	end

  describe '#version' do
    it 'should return the version' do
      @helper.version.should == @helper.version
      @helper.version.class.should == String
    end
  end

end