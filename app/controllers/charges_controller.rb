class ChargesController < ApplicationController
  def index
    @charges = current_account.charges.all
  end
end
