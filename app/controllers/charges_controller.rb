class ChargesController < ApplicationController
  
def new
  @stripe_btn_data = {
    key: "#{ Rails.configuration.stripe[:publishable_key] }",
    description: "Premium Membership - #{current_user.username}",
    amount: Amount.default
  }
end
  
def create
  # Creates a Stripe Customer object, for associating
  # with the charge
  customer = Stripe::Customer.create(
  email: current_user.email,
  card: params[:stripeToken]
  )
 
  # Where the real magic happens
  charge = Stripe::Charge.create(
  customer: customer.id, # Note -- this is NOT the user_id in your app
  amount: Amount.default,
    description: "Premium subscription - #{current_user.email}",
  currency: 'usd'
  )
 
  flash[:notice] = "Thanks for the subscription, #{current_user.username}! We appreciate your business."
  redirect_to edit_user_registration_path # or wherever
 
  # Stripe will send back CardErrors, with friendly messages
  # when something goes wrong.
  # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end 

  class Amount
    def self.default
      '1500'
    end
  end
  
end
