class Bing

  def initialize( pages )
    @url           = 'https://api.datamarket.azure.com/Bing/Search/Web?'
    @api_key       = SpiderConfig.api_key[:bing]
    @authorization = Base64.encode64("#{@api_key}:#{@api_key}").gsub("\n", '')
    @pages         = pages || ModuleHelper.default_pages
  end

  def get_all( domain )
    get_all_pages( domain )
    get_all_files( domain )
    get_domains( domain )
    get_url_keywords( domain )
    get_keywords( domain )
  end

  def get_all_pages( domain )
    @pages.times do |page|
      results = request( api_url( "site:#{domain}", page ) )

      unless results.empty?
        results.each do |result|
          ModuleHelper.output.urls << result['Url']
        end
      end
    end
  end

  def get_all_files( domain )
    ModuleHelper.file_extentions.each do |extention|
      results = request( api_url( "site:#{domain} ext:#{extention}", 0 ) )

      unless results.empty?
        results.each do |result|
          ModuleHelper.output.files << result['Url']
        end
      end
    end
  end

  def get_domains( domain )
    ip = ModuleHelper.domain_to_ip( domain )

    @pages.times do |page|
      results = request( api_url( "ip:#{ip}", 0 ) )

      unless results.empty?
        results.each do |result|
          result_host = URI(result['Url']).host
          ModuleHelper.output.ip_neighbours << result_host if ! ModuleHelper.same_host?( domain, result_host )
        end

      end
    end
  end

  def get_url_keywords( domain )
    ModuleHelper.url_keywords.each do |keyword|
      results = request( api_url( "site:#{domain} -instreamset:(url):groups #{keyword}", 0 ) )

      unless results.empty?
        results.each do |result|
          ModuleHelper.output.url_keywords << result['Url']
        end
      end
    end
  end

  def get_keywords( domain )
    ModuleHelper.keywords.each do |keyword|
      results = request( api_url( "site:#{domain} #{keyword}", 0 ) )

      unless results.empty?
        results.each do |result|
          ModuleHelper.output.keywords[result['Url']] = { keyword => result['Description'] }
        end
      end
    end
  end

  def request( url )
    response = Typhoeus.get( url, :headers => { "Authorization" => "Basic #{@authorization}" } )
    
    if response.body =~ /The authorization type you provided is not supported/
      puts '[ERROR] Did you put your API key in the api_keys.config file? or is it incorrect?'
      exit
    else
      JSON.parse( response.body )['d']['results']
    end
  end

  def api_url( query, page )
    @url + URI.encode("Query='#{query}'&$format=json&$skip=#{page}")
  end

end