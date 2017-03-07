class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    begin
      account = current_user.account
      token = params[:stripeToken]

      customer = account.stripe_customer_or_new(token)
      subscription = customer.subscriptions.create(
        plan: params[:plan],
      )

      account.assign_attributes(stripe_subscription_id: subscription.id)
      account.assign_attributes(
         card_brand: params[:card_brand],
         card_last4: params[:card_last4],
         card_exp_month: params[:card_exp_month],
         card_exp_year: params[:card_exp_year]
      ) if params[:card_last4]
      account.save

      flash.notice = "Success! Thanks for joining!"
      redirect_to dashboard_path
    rescue Stripe::CardError => e
      flash.alert = e.message
      render action: :new
    rescue
      flash.alert = "There was an error with our payment processor. Please try again and contact support if the error persists."
      render action: :new
    end
  end
end
