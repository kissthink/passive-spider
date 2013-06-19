class SpiderConfig

  CONFIG_FILE = 'api_keys.config'

  def self.config_file
    if File.exists?( CONFIG_FILE )
      File.open( CONFIG_FILE ).read
    else
      puts "[ERROR] Config file #{CONFIG_FILE} does not exist."
      exit
    end
  end

  def self.api_key
    keys = {}
    
    config_file.split("\n").each do |api_key|
    	key   = api_key.split("=>")[0].downcase.strip
    	value = api_key.split("=>")[1].strip

      keys[key.to_sym] = value
    end

    keys
  end

end