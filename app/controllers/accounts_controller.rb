class AccountsController < ApplicationController
  before_action :authenticate_user!

  def show
    @account = current_user.account
  end
end
