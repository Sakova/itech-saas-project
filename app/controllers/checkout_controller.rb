class CheckoutController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    @price = Stripe::Price.list(lookup_keys: ['saas_premium_plan'])['data'][0]['id']
    @session = Stripe::Checkout::Session.create({
      customer: (current_user ? current_user.stripe_customer_id : create_params[:stripe_customer_id]),
      success_url: root_url + (current_user ? '' : '?notice=true'),
      cancel_url: root_url + (current_user ? '' : '?notice=true'),
      payment_method_types: ['card'],
      line_items: [
        {price: @price, quantity: 1},
      ],
      mode: 'subscription',
    })
    respond_to do |format|
      format.js
    end
  end

  private

  def create_params
    params.require(:data_for_stripe).permit(:stripe_customer_id)
  end
end
