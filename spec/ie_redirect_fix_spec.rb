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

  context "given a to our app" do
    let(:location){ 'http://other-example.com/some/path' }
    let(:rack_response){ [302, { "Content-Type" => 'text/plain', 'Location' => location }, ["Some body"]] }

    let(:expected_location){ 'https://other-example.com/some/path' }

    it "should set the location to an SSL version of that URL" do
      response.headers['Location'].should == expected_location
    end

    its(:status){ should == 302 }
    its(:body)  { should == %Q{<html><body>You are being <a href="#{expected_location}">redirected</a>.</body></html>} }
  end

  context "given a redirect an external URL" do
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

