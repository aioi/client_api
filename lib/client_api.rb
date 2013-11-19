require 'rubygems'
require 'faraday_middleware'
require 'client_api/api'
require 'client_api/base_data_presenter'

module ClientApi

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

    def api_path(path)
      default_options[:api_path] = path
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

    def get_all_data_fields(path, options={})
      connect.get_all_data_fields(path, options)
    end

    def post(options={})
      connect.post(options)
    end

    def update(id, options={})
      connect.put(id, options)
    end

    def get_url_for_document(id)
      File.join(@default_options[:server_uri], File.join(@default_options[:app_obj], "#{id}"))
    end

    private

    def connect
      @connect = ClientApi::Api.new(@default_options) if @connect.nil?
      #@connect = ClientApi::Api.new if @connect.nil?
      @connect
    end
  end


end
