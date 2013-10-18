require 'rubygems'
require 'faraday_middleware'
require 'client_api/api'

module ClientApi

  #SERVER_URL = 'http://localhost:3000/api'
  #SERVER_API_VER = 'v1'
  #SERVER_END_OBJ = 'documents'
  #AUTH_TOKEN = 'jPKvkgHGm9Q3yZcsVbzM'

  class WhoIs
    def self.test
      puts "Hello there !!"
    end
  end

  def self.included(base)
    base.extend ClassMethods
    #base.send :include, HTTParty::ModuleInheritableAttributes
    #base.send(:mattr_inheritable, :default_options)
    #base.send(:mattr_inheritable, :default_cookies)
    base.instance_variable_set("@default_options", {})
    #base.instance_variable_set("@cookies", CookieHash.new)
  end

  module ClassMethods

    def default_options
      @default_options
    end

    def server_uri(uri=nil)
      default_options[:server_uri] = uri
    end

    def api_ver(ver)
      default_options[:api_ver] = ver
    end

    def app_obj(app)
      default_options[:app_obj] = app
    end

    def auth_token(token)
      default_options[:auth_token] = token
    end

    def get(id)
      connect.get(id)
    end

    def get_document_types(path, options={})
      connect.get_document_types(path, options)
    end

    def get_data_fields(path, options={})
      connect.get_data_fields(path, options)
    end

    def post(options={})
      connect.post(options)
    end


    private

    def connect
      @connect = ClientApi::Api.new(@default_options) if @connect.nil?
      #@connect = ClientApi::Api.new if @connect.nil?
      @connect
    end
  end


end