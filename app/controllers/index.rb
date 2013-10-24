get '/' do
  Stripe.api_key = settings.api_key
  # Look in app/views/index.erb
  erb :index
end

get "/play" do

  erb :play
end


post '/draw' do

  if request.xhr?
    value = params[:value].to_i

    @draw = value ? Card.create({ value: value }) : Card.create

    erb :index
  end

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