require "rack-ie-redirect-fix/version"

module Rack
  class IeRedirectFix
    def initialize app
      @app = app
    end

    def call env
      status, headers, body = @app.call env
      if status.to_i == 302 and headers['Location'] and headers['Location'] !~ /[a-zA-Z]+:\/\//
        headers = headers.merge 'Location' => "https://#{env['SERVER_NAME']}#{headers['Location']}"
        body = [""]
      end
      [status, headers, body]
    end
  end
end
