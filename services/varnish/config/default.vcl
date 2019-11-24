
#
# This is an example VCL file for Varnish.
#
# It only includes minimum configuration to start and is not suitable for 
# most systems out of the box.
#
# See the VCL chapters in the Users Guide at https://www.varnish-cache.org/docs/
# and https://www.varnish-cache.org/trac/wiki/VCLExamples for more examples.

# Marker to tell the VCL compiler that this VCL has been adapted to the
# new 4.0 format.
vcl 4.0;


# Default backend definition. Set this to point to your content server.
# Backend can be the dockerized service that is running the web server, i.e. `apache` or `nginx`.
backend default {
  .host = "apache";
  .port = "80";
}


sub vcl_recv {
  # Happens before we check if we have this in cache already.
  #
  # Typically you clean up the request here, removing cookies you don't need,
  # rewriting the request, etc.

  ## Restrict cache-control.
  # unset req.http.Cache-Control;
  # unset req.http.Pragma;

  ## Exclude the admin, login, logout, etc. requests.
  if (req.url ~ "/admin"
      || req.url ~ "/login"
      || req.url ~ "/user"
      || req.url ~ "/wp-admin"
      || req.url ~ "/wp-login\.php"
      || req.url ~ "/logout") {
    return(pass);
  }

  ## Exclude if request has any cookie name that contains particular strings i.e. "username" in it.
  if (req.http.Cookie ~ "username"
      || req.http.Cookie ~ "wordpress_logged_in") {
    return (pass);
  }

  ## Only cache GET or HEAD requests.
  if (req.method != "GET" && req.method != "HEAD") {
    return (pass);
  }

  ## Remove ALL cookies at this point.
  # unset req.http.Cookie;

  return (hash);
}


sub vcl_backend_response {
  # Happens after we have read the response headers from the backend.
  #
  # Here you clean the response headers, removing silly Set-Cookie headers
  # and other mistakes your backend does.

  ## Removes Set-Cookie on everything except admin, login, logout, etc. url's.
  if (!(bereq.url ~ "/admin"
      || bereq.url ~ "/login"
      || bereq.url ~ "/user"
      || bereq.url ~ "/wp-admin"
      || bereq.url ~ "/wp-login\.php"
      || bereq.url ~ "/logout")) {
    unset beresp.http.set-cookie;
  }

  return (deliver);
}


sub vcl_deliver {
  # Happens when we have all the pieces we need, and are about to send the
  # response to the client.
  #
  # You can do accounting or modifying the final object here.

  ## Echo.
  set resp.http.X-Built-By = "dockerized";

  ## Debug header.
  if (obj.hits > 0) {
    set resp.http.X-Varnish-Cache = "HIT";
  } else {
    set resp.http.X-Varnish-Cache = "MISS";
  }

  ## Strip unnecessary headers: i.e. PHP version, web server, generator, etc.
  unset resp.http.Via;
  unset resp.http.Server;
  unset resp.http.X-Powered-By;
  unset resp.http.X-Generator;
  unset resp.http.Link;
  unset resp.http.X-Drupal-Cache;

  return (deliver);
}
