class Output

  attr_accessor :urls, :files, :ip_neighbours, :subdomains, :keywords, :url_keywords, :query_count

  def initialize
    @urls          = []
    @files         = []
    @ip_neighbours = []
    @subdomains    = {}
    @keywords      = {}
    @url_keywords  = []
    @query_count   = 0
  end

  def stdout
    puts "[+] URLs: #{parsed_urls.size}"
    puts
    puts parsed_urls
    puts
    puts "[+] Files: #{parsed_files.size}"
    puts
    puts parsed_files
    puts
    puts "[+] IP Neighbours: #{parsed_ip_neighbours.size}"
    puts
    puts parsed_ip_neighbours
    puts
    puts "[+] Subdomains: #{subdomains.size}"
    puts
    
    subdomains.each_pair do |domain, ip|
      puts "#{domain} #{ip}"
    end

    puts
    puts "[+] Interesting URL Keywords: #{url_keywords.size}"
    puts
    puts url_keywords
    puts
    puts "[+] Interesting Keywords: #{keywords.size}"

    keywords.each_pair do |url, data|
      puts
      data.each_pair do |keyword, description|
        puts "Keyword: #{keyword}" 
        puts "URL: #{url}"
        puts "Description: #{description}"
      end
    end

    puts
    puts "[+] Number of API queries made: #{@query_count}"
    puts
  end

  def parsed_urls
    @urls.uniq
  end

  def parsed_files
    @files.uniq
  end

  def parsed_ip_neighbours
    @ip_neighbours.uniq
  end

end