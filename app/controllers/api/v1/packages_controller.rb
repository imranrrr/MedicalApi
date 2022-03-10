require 'sinatra'
require 'stripe'

class Api::V1::PackagesController < ApplicationController
	before_action :authenticate_user!

	before_action :set_package, only: [:buy_package]

  # GET /directories
  def index
    @packages = Package.all

    render json: @packages
  end

  def buy_package
    
    Stripe.api_key = "sk_test_51HrkFGF6cAgTtJEZsQFjGf3wZdkAs4s31xrhrJeSjb8dLkadpp5b8i53wUZw7qeUEkefFZ5wXI220hQTjUac7dlq00bZyCIxqx"
    payment_intent = Stripe::PaymentIntent.create(
      amount: @package.price,
      currency: 'usd',
      automatic_payment_methods: {
        enabled: true,
      },
    )
    clientSecret = payment_intent['client_secret']
    
    if clientSecret
      Subscription.create!(user_id: current_user.id, status: 0, package_id: @package.id)
    end
    render_success({clientSecret: clientSecret})
  end

  def redirect_request
     stripe_data = params[:stripeParams].split('&')
     payment_intent = stripe_data[0].split('payment_intent=')[1]
     stripe_result = payment_intent = stripe_data[2].split('redirect_status=')[1]

    if stripe_result == 'succeeded'
      current_user.subscription.update(status: 1)
      current_user.update(stripe_account_intent: payment_intent, paid: true)
    end

    render_success({user: current_user.reload})

  end

  # GET /directories/1
  

  private
    def set_package
      @package = Package.find(params[:id])
    end
end