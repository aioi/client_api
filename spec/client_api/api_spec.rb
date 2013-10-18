require "spec_helper"

describe ClientApi::Api do
  describe "get different types of information from server" do
    it "obtains the document of the given document id" do
      data = {
          :batch_id => nil,
          :version => nil,
          :scheme => "Toyota",
          :id =>1,
          :created_at => "2013-10-09T11:33:59+11:00",
          :workflow_state => "draft",
          :user_id => 24,
          :updated_at=> "2013-10-09T11:33:59+11:00",
          :status => nil,
          :data => {},
          :entity =>"Company"

      }
      #WebMock.enable!
      #WebMock.disable_net_connect!

      #stub_request(:any, "www.example.com")
      stub_request(:any, "www.example.com").with(:headers => {'Accept'=>'*/*'}).to_return(:status => 200, :body => "", :headers => {})
      res = Net::HTTP.get("www.example.com", "/")

	#stub_request(:any, "www.example.com").to_return(:status => [500, "Internal Server Error"])

      req = Net::HTTP::Get.new("/")
      Net::HTTP.start("www.example.com") {|http| http.request(req)}.message 



      #stub_request(:get, "http://localhost:3000/api/v1/documents/1?access_token=token").with(:headers => {'Accept'=>'*/*', 'Authorization'=>'Token token="token"', 'Connection'=>'keep-alive', 'Keep-Alive'=>'30', 'User-Agent'=>'Faraday v0.8.8'}).to_return(:status => 200, :body => "", :headers => {})
      #stub_request(:get, "http://localhost:3000/api/v1/documents/1?access_token=token").to_return(:status => 200, :body => "hello", :headers => {})
      #stub_request(:get, "http://localhost:3000/api/v1/documents/1?access_token=token").to_return(:status => 200, :body => fixture('doc_object_body.txt').read, :headers => {} )
      stub_request(:get, "http://localhost:3000/api/v1/documents/1?access_token=token").to_return(:status => 200, :body => data, :headers => {} )


      #ClientApi::Api.new(:auth_token => 'token').get(1)
      option = {:server_uri => 'http://localhost:3000/api',
                :api_ver => 'v1',
                :app_obj => 'documents',
                :auth_token => 'token'
      }
      req_api =  ClientApi::Api.new(option)
      res = req_api.get(1)
      res[:id].should == 1



    end



  end
end
