passive-spider
==============

Passive Spider uses search engines to find interesting information about a target domain.

#### LICENSE

Use it, modify it and distribute it without warranty or implied warranty.

#### INSTALL

```git clone https://github.com/RandomStorm/passive-spider.git```

```cd passive-spider```

```gem install bundler && bundle install```

Place your search engine API keys in the api_keys.config file. Each search engine API has different usage limits and pricing, refer to them for this information. Do not share your keys.

Tested on Mac OS X with Ruby 1.9.3.

#### ARGUMENTS

    --domain   || -d    The domain you would like to use as a target.
    --pages    || -p    The number of pages you would like to hit from the search engine. Default: 20
    --all      || -a    Do all of the spidering checks. This is the default check.
    --allpages          Find all pages related to the domain, limited by the --pages option.
    --allfiles          Find all file types related to the domain, limited to the ones configured.
    --neighbours        Find other domains that are on the same IP address.
    --urlkeywords       Find page URLs that have 'interesting' keywords in them.
    --keywords          Find page content that have 'interesting' keywords in them.
    --help     || -h    This output.

#### USAGE

    - Run all checks against the given domain...
    ruby pspider.rb -d www.example.com

    - Run all checks against the admin subdomain...
    ruby pspider.rb -d admin.example.com

    - Run all checks against the given domain, limited to 50 search engine pages...
    ruby pspider.rb -d www.example.com -p 50

    - Run the IP Neighbour check against the given domain...
    ruby pspider.rb -d www.example.com --neighbours