class ModuleHelper

  def self.default_pages
    20
  end

  def self.file_extentions
    %w(pdf log txt doc docx csv xls xlsx bak back backup zip tar tar.gz)
  end

  def self.keywords
    %w(admin login user username password error)
  end

  def self.url_keywords
    %w(admin login)
  end

  def self.domain_to_ip( domain )
    IPSocket::getaddress( domain )
  end

  def self.output
    @output ||= Output.new
  end

  def self.same_host?( input_host, result_host )
    input_host === result_host
  end

end