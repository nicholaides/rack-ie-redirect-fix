require 'spec_helper'

describe Rack::IeRedirectFix do
  let(:app) do
    Rack::IeRedirectFix.new(lambda{|env| rack_response })
  end
  let(:response){ get 'http://other-example.com/' }
  subject{ response }

  context "given a non-redirect" do
    let(:status) { 200 }
    let(:headers){ { "Content-Type" => 'text/plain' } }
    let(:body)   { "hi" }

    let(:rack_response){ [status, headers, [body]] }

    its(:status){ should == status }
    its(:body)  { should == body }

    it "should leave the headers alone" do
      headers.each do |name, value|
        response.headers[name].should == value
      end
    end
  end

  context "given a redirect to a path" do
    let(:location){ '/some/path.html' }
    let(:rack_response){ [302, { "Content-Type" => 'text/plain', 'Location' => location }, ["Redirecting to <a href='/some/path.html'>"]] }

    it "should set the location to an absolute URL" do
      response.headers['Location'].should == 'https://other-example.com/some/path.html'
    end

    its(:status){ should == 302 }
    its(:body)  { should == "" }
  end

  context "given a redirecto to a URL" do
    let(:location){ 'http://google.com/some/path.html' }
    let(:headers){ { "Content-Type" => 'text/plain', 'Location' => location } }
    let(:body) { "Redirecting to somewhere" }
    let(:rack_response){ [302, headers, [body]] }

    its(:status){ should == 302 }
    its(:body)  { should == body }
    it "should leave the headers alone" do
      headers.each do |name, value|
        response.headers[name].should == value
      end
    end
  end
end

