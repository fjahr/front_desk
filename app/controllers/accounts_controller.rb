class AccountsController < ApplicationController
  before_action :authenticate_user!
end
