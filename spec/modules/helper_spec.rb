require 'spec_helper'

describe '.ModuleHelper' do

  describe '#same_domain?' do
  	it 'returns true if both domains are the same' do
      ModuleHelper.same_domain?( PublicSuffix.parse('example.com'), PublicSuffix.parse('example.com') ).should be_true
  	end

  	it 'returns false if both domains are different' do
      ModuleHelper.same_domain?( PublicSuffix.parse('example.com'), PublicSuffix.parse('example2.com') ).should be_false
    end
  end

  describe '#subdomain?' do
    it 'returns true if the domain is a subdomain' do
      ModuleHelper.subdomain?( PublicSuffix.parse('example.com'), PublicSuffix.parse('subdomain.example.com') ).should be_true
    end

    it 'returns false if the domain does not contain a subdomain' do
      ModuleHelper.subdomain?( PublicSuffix.parse('example.com'), PublicSuffix.parse('example.com') ).should be_false
    end

    it 'returns false if the domains do not match' do
      ModuleHelper.subdomain?( PublicSuffix.parse('example.com'), PublicSuffix.parse('example2.com') ).should be_false
    end

    it 'returns false if the domains do not match and the domain is a subdomain' do
      ModuleHelper.subdomain?( PublicSuffix.parse('example.com'), PublicSuffix.parse('subdomain.example2.com') ).should be_false
    end

    it 'returns false if the subdomains are the same' do
      ModuleHelper.subdomain?( PublicSuffix.parse('subdomain.example.com'), PublicSuffix.parse('subdomain.example.com') ).should be_false
    end
  end

  describe '#parse_domain' do
  	it 'returns the domain from a URL' do
  	  ModuleHelper.parse_domain( 'http://www.example.com' ).domain.should == 'example.com'
  	end
  end

end