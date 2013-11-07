require 'rubygems'
require 'faraday_middleware'

module ClientApi

  class Api
    #attr_accessor :app_name, :http_adapter, :target_url
    #autoload :FaradayMiddleware, 'faraday_middleware'

    def initialize(options={})
      @server_uri = options[:server_uri]
      @auth_token = options[:auth_token]
      @api_ver = options[:api_ver]
      @app_obj = options[:app_obj]
      @target_path = "#{@api_ver}/#{@app_obj}"

      connect
    end

    #def get(id)
    #  response = @api_conn.get "#{@api_ver}/#{@end_obj}/#{id}"
    #  puts "get:  #{response.inspect}"
    #  end

    def get(id, options={})
      response = request(:get, "#{@target_path}/#{id}", options)
    end

    def get_document_types(path, options={})
      response = request(:get, "#{@target_path}/#{path}/#{__method__}", options)
    end

    def get_data_fields(path, options={})
      response = request(:get, "#{@target_path}/#{path}/#{__method__}?type=#{options[:type]}", options)
    end

    def get_all_data_fields(path, options={})
      response = request(:get, "#{@target_path}/#{path}/#{__method__}", options)
    end

    def post(options={})
      response = request(:post, "#{@target_path}", options)
    end

    def put(id, options={})
      response = request(:put, "#{@target_path}/#{id}", options)
    end

    private

    def connect
      @api_conn = Faraday.new(@server_uri) do |conn|
        conn.request :oauth2, @auth_token
        conn.request :json

        conn.response :xml,  :content_type => /\bxml$/
        conn.response :json, :content_type => /\bjson$/

        #conn.use :instrumentation


        # keep http connection alive for the multiple requests
        # the connection will be reset (closed-reconnected) after the connection is idle for
        # the number of seconds defined in idle_timeout, 5 seconds by default, nil=> no timeout (no reset)
        conn.adapter :net_http_persistent do |http|
          http.idle_timeout = 10
        end
        #conn.adapter Faraday.default_adapter
      end
    end

    def request(action, path, options)
      #check_login_status if options[:require_auth]
      #headers = auth_token ? { 'AUTHORIZATION' => auth_token } : {}
      headers = {}
      headers.merge!(options[:headers]) if options[:headers]

      response = @api_conn.send(action, path) do |request|
        request.body = options[:body] if options[:body]
        #puts "request: #{request.inspect}"
        #puts ""
        request.headers = headers unless headers.empty?
      end

      #puts "raw response of response:  #{response.inspect}"
      #puts ""
      #puts "response status:  #{response.status}"
      response.body
    end
  end
  end
