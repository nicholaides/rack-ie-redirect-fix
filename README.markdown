# IE Redirect Fix

This is a Rack middleware that fixes an IE issue related to redirects that occurs when all of the following are true:

1. Your loadbalancer is taking care of SSL and the Rails (or other) app thinks it's running straight HTTP
2. Your loadbalancer rewrites the Location header HTTP 302 responses to an https address, but doesn't rewrite the message body as well.
3. Your app includes multipart forms that submit with a file uploaded and then redirect with a 302
