set :publishable_key, ENV['PUBLISHABLE_KEY']
set :secret_key, ENV['SECRET_KEY']

Stripe.api_key = settings.secret_key

get '/' do
  # Look in app/views/index.erb
  erb :index
end


post '/charge' do
  # Amount in cents
  @amount = 500

  customer = Stripe::Customer.create(
    :email => 'customer@example.com',
    :card  => params[:stripeToken]
    )

  charge = Stripe::Charge.create(
    :amount      => @amount,
    :description => 'Sinatra Charge',
    :currency    => 'usd',
    :customer    => customer.id
    )

  erb :charge
end



# Stripe::Customer.create(
#   {:description=> "example@stripe.com"},
#   ACCESS_TOKEN # user's access token from the Stripe Connect flow
# )