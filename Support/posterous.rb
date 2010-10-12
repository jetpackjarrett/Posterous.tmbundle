%w{rubygems active_support httparty base64 erb pp}.each { |f| require f }

module Posterous

  extend self
  
  def config
    @config = File.open(File.join(ENV['HOME'], '.posterous'), 'r') { |f| YAML.load(f) }
  end
  
  class Api
    
    include HTTParty
    base_uri 'https://posterous.com/api/2/users/me'
    
    class << self;
    
      def default_query
        return {
          :basic_auth => {
            :username => Posterous.config['username'],
            :password => Posterous.config['password']
          },
          :query => { :api_token => Posterous.config['api_token'] }
        }
      end

      def default_site
        site = Posterous.config['default_site_id'] ? Posterous.config['default_site_id'].to_s : 'primary'
        return '/' + site
      end

      def get_request(endpoint, query = {})
        params         = self.default_query
        params[:query] = params[:query].merge(query)
        return self.get(endpoint, params)
      end

      def post_request(endpoint, query = {})
        params         = self.default_query
        params[:query] = params[:query].merge(query)
        return self.post(endpoint, params)
      end

      def handle_response(response)
        case response.code
          when 200
            return 'Post created!'
          when 401
            return 'Unauthorized.  Make sure ~/.posterous exists and proper username/password are defined.'
          when 500
            return 'Application error.  The API is probably down.'
          else
            return 'Unknown error'
        end 
      end
    
    self end
    
  end
  
  class Post < Posterous::Api
    
    class << self;

      def parse(raw)
        allowed   = ['ID', 'TITLE', 'TAGS', 'AUTOPOST', 'DISPLAY_DATE']
        is_option = Regexp.new(/^\w+: \w+/) 
        options   = []
        post      = [] 

        raw.each do |line|
          if (is_option === line and allowed.include?(line.chomp[/^\w+/]))
            options.push(line.chomp)
          else
            post.push(line.chomp)
          end
        end

        if (options.length > 0)
          parsed = YAML.load(options.join("\n"))
          parsed.each { |k, v|
            parsed.delete(k)
            parsed[k.downcase] = v
          }
        else
          parsed = {}
        end

        parsed['body'] = post.join('')
        return parsed.to_options
      end

      def create(params)
        if (params.kind_of? String)
          params = self.parse(params)
        end
        
        defaults = {
          :body         => '',
          :title        => '',
          :tags         => '',
          :autopost     => Posterous.config['autopost'] ? Posterous.config['autopost'] : false,
          :display_date => Time.now
        }
        params = defaults.merge(params)
        
        endpoint = '/sites' + self.default_site + '/posts'
        pp endpoint
        if (params[:id])
          pp endpoint + '/' + params[:id]
        end 
        exit
        
        response = self.post_request(endpoint, {:post => params})
        if (response.code == 200)
          system('open ' + response['full_url'])
        end

        return self.handle_response(response)
      end

    self end
  
  end

end