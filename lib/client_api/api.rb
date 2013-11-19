require 'rubygems'
require 'faraday_middleware'

module ClientApi

  class Api
    #attr_accessor :app_name, :http_adapter, :target_url
    #autoload :FaradayMiddleware, 'faraday_middleware'

    def initialize(options={})
      @server_uri = options[:server_uri]
      @auth_token = options[:auth_token]
      @api_path = options[:api_path]
      @api_ver = options[:api_ver]
      @app_obj = options[:app_obj]
      @server_url = File.join(@server_uri, @api_path)
      @target_path = File.join(@api_ver, @app_obj)

      connect
    end

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
      @api_conn = Faraday.new(@server_url) do |conn|
        conn.request :oauth2, @auth_token
        conn.request :json

        conn.response :xml,  :content_type => /\bxml$/
        conn.response :json, :content_type => /\bjson$/

        conn.request :multipart
        conn.request :url_encoded

        #conn.use :instrumentation


        # keep http connection alive for the multiple requests
        # the connection will be reset (closed-reconnected) after the connection is idle for
        # the number of seconds defined in idle_timeout, 5 seconds by default, nil=> no timeout (no reset)
        #conn.adapter :net_http_persistent do |http|
          #http.idle_timeout = 10
        #end
        conn.adapter :net_http
      end
    end

    def request(action, path, options)
      headers = {}
      headers.merge!(options[:headers]) if options[:headers]

      response = @api_conn.send(action, path) do |request|
        request.body = options[:body] if options[:body]
        request.headers = headers unless headers.empty?
      end

      response.body
    end
  end
  end
