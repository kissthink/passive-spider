class LibHelper

  def version
   '0.2'
  end

  def banner
    puts
    puts "[+]-----------------------------[+]"
    puts "[+]     Passive Spider v#{version}     [+]" 
    puts "[+]-----------------------------[+]"
    puts
    puts "Shhhhh... by Ryan 'ethicalhack3r' Dewhurst"
    puts "Part of The RandomStorm Open Source Initiative"
    puts
  end

  def help
    puts "Description: Passive Spider uses search engines to find interesting information about a target domain."
    puts
    puts "Prerequisites:"
    puts
    puts "You must obtain your own API keys and place them in the config file. Charges may apply depending on your usage."
    puts
    puts "Arguments:"
    puts 
    puts "--domain   || -d    The domain you would like to use as a target."
    puts "--pages    || -p    The number of pages you would like to hit from the search engine. Default: #{ModuleHelper.default_pages}"
    puts "--all      || -a    Do all of the spidering checks. This is the default check."
    puts "--allpages          Find all pages related to the domain, limited by the --pages option."
    puts "--allfiles          Find all file types related to the domain, limited to the ones configured."
    puts "--neighbours        Find other domains that are on the same IP address."
    puts "--urlkeywords       Find page URLs that have 'interesting' keywords in them."
    puts "--keywords          Find page content that have 'interesting' keywords in them."
    puts "--help     || -h    This output."
  end

  def usage
    puts "Usage:"
    puts
    puts "- Run all checks against the given domain..."
    puts "ruby pspider.rb -d www.example.com"
    puts
    puts "- Run all checks against the admin subdomain..."
    puts "ruby pspider.rb -d admin.example.com"
    puts
    puts "- Run all checks against the given domain, limited to 50 search engine pages..."
    puts "ruby pspider.rb -d www.example.com -p 50"
    puts
    puts "- Run the IP Neighbour check against the given domain..."
    puts "ruby pspider.rb -d www.example.com --neighbours"
  end
end