class SpiderConfig

  CONFIG_FILE = 'api_keys.config'

  def self.config_file
    if ! File.exists?( CONFIG_FILE )
      puts "[ERROR] Config file #{CONFIG_FILE} does not exist."
      exit
    elsif File.symlink?( CONFIG_FILE )
      puts "[ERROR] Config file #{CONFIG_FILE} is a symlink."
      exit
    else
      File.open( CONFIG_FILE ).read
    end
  end

  def self.api_key
    keys = {}

    JSON.parse( config_file ).each_pair do |engine, api_key|
      keys[engine.downcase.to_sym] = api_key
    end

    keys
  end

end