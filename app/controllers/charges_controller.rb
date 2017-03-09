class ChargesController < ApplicationController
  before_action authenticate_user!

  def index
    @charges = current_account.charges.all
  end

  def show
    @charge = current_account.charges.find(params[:id])

    respond_to do |format|
      format.pdf {
        send_data(
          @charge.receipt.render,
          filename: "front-desk-receipt-#{@charge.created_at.to_date.to_s}.pdf",
          type: "application/pdf",
          disposition: :attachment
        )
      }
    end
  end
end
