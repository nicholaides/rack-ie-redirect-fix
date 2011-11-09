require "rack-ie-redirect-fix/version"

module Rack
  class IeRedirectFix
    def initialize app
      @app = app
    end

    def call env
      status, headers, body = @app.call env

      if status.to_i == 302 and headers['Location'] and headers['Location'] !~ /[a-zA-Z]+:\/\//
        location = "https://#{env['SERVER_NAME']}#{headers['Location']}"
        headers  = headers.merge 'Location' => location
        body     = [%Q{Redirecting to <a href="#{location}">#{location}</a>.}]
      end

      [status, headers, body]
    end
  end
end
