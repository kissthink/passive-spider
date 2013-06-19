class Output

  attr_accessor :urls, :files, :ip_neighbours, :keywords, :url_keywords

  def initialize
  	@urls          = []
  	@files         = []
  	@ip_neighbours = []
    @keywords      = {}
    @url_keywords  = []
  end

  def stdout
  	puts "[+] URLs #{parsed_urls.size}"
  	puts
  	puts parsed_urls
  	puts
  	puts "[+] Files #{parsed_files.size}"
  	puts
    puts parsed_files
    puts
    puts "[+] IP Neighbours #{parsed_ip_neighbours.size}"
    puts
    puts parsed_ip_neighbours
    puts
    puts "[+] Interesting URL Keywords #{parsed_url_keywords.size}"
    puts
    puts parsed_url_keywords
    puts
    puts "[+] Interesting Keywords #{keywords.size}"

    keywords.each_pair do |url, data|
      puts
      data.each_pair do |keyword, description|
        puts "Keyword: #{keyword}" 
        puts "URL: #{url}"
        puts "Description: #{description}"
      end
    end

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

  def parsed_url_keywords
    @url_keywords.uniq
  end

end