require "rack-ie-redirect-fix/version"
require 'uri'

module Rack
  class IeRedirectFix
    def initialize app
      @app = app
    end

    def call env
      status, headers, body = @app.call env

      if status.to_i == 302
        uri = URI.parse headers['Location']
        if uri.scheme == "http" and uri.host == env['SERVER_NAME']
          uri.scheme = 'https'
          body_str   = %Q{<html><body>You are being <a href="#{uri.to_s}">redirected</a>.</body></html>}

          headers    = headers.merge 'Location'       => uri.to_s,
                                     'Content-Length' => body_str.size # The RSpec tests don't pick this up, but this is necessary
          body       = [body_str]
        end
      end

      [status, headers, body]
    end
  end
end
