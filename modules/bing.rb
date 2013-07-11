class Bing

  def initialize( target_domain, pages )
    @api_url       = 'https://api.datamarket.azure.com/Bing/Search/Web?'
    @api_key       = SpiderConfig.api_key[:bing]
    @authorization = Base64.encode64("#{@api_key}:#{@api_key}").gsub("\n", '')
    @pages         = pages || ModuleHelper.default_pages
    @target_domain = target_domain
    @result_urls   = []
  end

  def get_all
    get_all_pages
    get_all_files
    get_ip_neighbours
    get_url_keywords
    get_keywords
  end

  def get_all_pages
    @pages.times do |page|
      results = request( api_url( "site:#{@target_domain}", page ) )

      unless results.empty?
        results.each do |result|
          ModuleHelper.output.urls << result['Url']
          @result_urls << result['Url']
        end
      end
    end

    get_subdomains_from_results
  end

  def get_all_files
    ModuleHelper.file_extentions.each do |extention|
      results = request( api_url( "site:#{@target_domain} ext:#{extention}", 0 ) )

      unless results.empty?
        results.each do |result|
          ModuleHelper.output.files << result['Url']
          @result_urls << result['Url']
        end
      end
    end

    get_subdomains_from_results
  end

  def get_url_keywords
    ModuleHelper.url_keywords.each do |keyword|
      results = request( api_url( "site:#{@target_domain} -instreamset:(url):groups #{keyword}", 0 ) )

      unless results.empty?
        results.each do |result|
          ModuleHelper.output.url_keywords << result['Url']
          @result_urls << result['Url']
        end
      end
    end

    get_subdomains_from_results
  end

  def get_keywords
    ModuleHelper.keywords.each do |keyword|
      results = request( api_url( "site:#{@target_domain} #{keyword}", 0 ) )

      unless results.empty?
        results.each do |result|
          ModuleHelper.output.keywords[result['Url']] = { keyword => result['Description'] }
          @result_urls << result['Url']
        end
      end
    end

    get_subdomains_from_results
  end

  def get_ip_neighbours
    ip     = ModuleHelper.domain_to_ip( @target_domain )
    domain = PublicSuffix.parse( @target_domain )

    @pages.times do |page|
      results = request( api_url( "ip:#{ip}", 0 ) )

      unless results.empty?
        results.each do |result|
          result_domain = ModuleHelper.parse_domain( result['Url'] )

          if ! ModuleHelper.same_domain?( domain, result_domain )
            ModuleHelper.output.ip_neighbours << result_domain.to_s
          end     
        end
      end
    end

    get_subdomains_from_results
  end

  def get_subdomains_from_results
    target_domain = PublicSuffix.parse( @target_domain )

    @result_urls.each do |result|
      result_domain = ModuleHelper.parse_domain( result )

      if ModuleHelper.subdomain?( target_domain, result_domain )
        ModuleHelper.output.subdomains[result_domain.to_s] = ModuleHelper.domain_to_ip( result_domain.to_s )
      end
    end

    @result_urls.clear
  end

  def request( url )
    response = Typhoeus.get( url, :headers => { "Authorization" => "Basic #{@authorization}" } )

    if response.body =~ /The authorization type you provided is not supported/
      puts '[ERROR] Did you put your API key in the api_keys.config file? or is it incorrect?'
      exit
    elsif response.code == 403
      puts '[ERROR] Your Key seems to work but have you subscribed to the "Bing Search API"?'
      exit
    elsif response.body =~ /Insufficient balance for the subscribed offer in user's account/
      puts '[ERROR] You have run out of free API queries.'
      exit
    else
      JSON.parse( response.body )['d']['results']
    end
  end

  def api_url( query, page )
    @api_url + URI.encode("Query='#{query}'&$format=json&$skip=#{page}")
  end

end