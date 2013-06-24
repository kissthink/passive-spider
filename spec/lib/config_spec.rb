require 'spec_helper'

describe '.SpiderConfig' do

  describe '#config_file' do
  	context 'when loading config file' do
  		it 'should be valid JSON' do
  		  JSON.parse(SpiderConfig.config_file)
      end
    end
  end

  describe '#api_key' do
  	context 'when parsing config file' do
  		it 'should parse the config file' do
  			SpiderConfig.api_key.should include :bing
  		end
  	end
  end

end