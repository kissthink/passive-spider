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

  describe '#domain_exists?' do
  	it 'returns true if the domain exists' do
  	  @helper.domain_exists?( 'randomstorm.com' ).should be_true
    end

    it 'returns false if the domain does not exists' do
  	  @helper.domain_exists?( "randomstorm#{(0...8).map{(65+rand(26)).chr}.join.downcase}.com" ).should be_false
    end
  end

end