require 'sinatra'
require 'stripe'

class Api::V1::PaymentController < ApplicationController

	def create
		Stripe.api_key = "sk_test_51HrkFGF6cAgTtJEZsQFjGf3wZdkAs4s31xrhrJeSjb8dLkadpp5b8i53wUZw7qeUEkefFZ5wXI220hQTjUac7dlq00bZyCIxqx"

		session = Stripe::Checkout::Session.create({
		  ine_items: [{
		    price_data: {
			    currency: 'usd',
			    product_data: {
			      name: 'T-shirt',
			    },
			    unit_amount: 2000,
		    },
		    quantity: 1,
		  }],
	    mode: 'payment',
	    # These placeholder URLs will be replaced in a following step.
	    success_url: 'https://example.com/success',
	    cancel_url: 'https://example.com/cancel',
	  })
	end


end
