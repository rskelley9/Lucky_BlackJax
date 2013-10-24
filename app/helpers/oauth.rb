def oauth_consumer
  raise RuntimeError, "You must set PUBLISHABLE_KEY and SECRET_KEY in your server environment." unless ENV['PUBLISHABLE_KEY'] and ENV['SECRET_KEY']
  @consumer ||= OAuth::Consumer.new(
    ENV['PUBLISHABLE_KEY'],
    ENV['SECRET_KEY'],
    :site => "https://connect.stripe.com"
  )
end

def request_token
  if not session[:request_token]
    # this 'host_and_port' logic allows our app to work both locally and on Heroku
    host_and_port = request.host
    host_and_port << ":9393" if request.host == "localhost"

    # the `oauth_consumer` method is defined above
    session[:request_token] = oauth_consumer.get_request_token(
      :oauth_callback => "http://#{host_and_port}/auth"
    )
  end
  session[:request_token]
end
 # <script src="https://checkout.stripe.com/v2/checkout.js" class="stripe-button" data-key="<%= settings.publishable_key %>"></script>