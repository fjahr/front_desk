class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_subscription!, except: [:new, :create]

  def new
  end

  def edit
  end

  def show
  end

  def create
    begin
      account = current_user.account
      token = params[:stripeToken]

      customer = account.stripe_customer_or_new(token)
      subscription = customer.subscriptions.create(
        plan: params[:plan],
      )

      account.assign_attributes(stripe_subscription_id: subscription.id, expires_at: nil)
      account.assign_attributes(
         card_brand: params[:card_brand],
         card_last4: params[:card_last4],
         card_exp_month: params[:card_exp_month],
         card_exp_year: params[:card_exp_year]
      ) if params[:card_last4]
      account.save

      flash.notice = "Thanks for joining Front Desk! Let's get started by adding your integrations."
      redirect_to integrations_path
    rescue Stripe::CardError => e
      flash.alert = e.message
      render action: :new
    rescue
      flash.alert = "There was an error with our payment processor. Please try again and contact support if the error persists."
      render action: :new
    end
  end

  def update
    begin
      account = current_user.account
      token = params[:stripeToken]

      customer = account.stripe_customer
      source = customer.sources.create(source: token)
      customer.default_source = source.id
      customer.save

      account.assign_attributes(
         card_brand: params[:card_brand],
         card_last4: params[:card_last4],
         card_exp_month: params[:card_exp_month],
         card_exp_year: params[:card_exp_year]
      )
      account.save

      flash.notice = "Card was successfully updated."
      redirect_to subscription_path
    rescue Stripe::CardError => e
      flash.alert = e.message
      render action: :edit
    rescue
      flash.alert = "There was an error with our payment processor. Please try again and contact support if the error persists."
      render action: :edit
    end
  end

  def destroy
    customer = current_account.stripe_customer
    subscription = customer.subscriptions.retrieve(current_account.stripe_subscription_id).delete

    expires_at = Time.zone.at(subscription.current_period_end)
    current_account.update(expires_at: expires_at, stripe_subscription_id: nil)

    redirect_to subscription_path, notice: "Your subscription has been cancelled. You will have access until #{current_account.expires_at.to_date}."
  end
end
