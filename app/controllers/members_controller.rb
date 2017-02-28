class MembersController < InheritedResources::Base
  def new
    @member = Member.new(account: current_user.account)
  end

  def show
    @member = current_user.account.members.find_by(sequential_id: params[:id])
  end

  private

    def member_params
      params.require(:member).permit(:account_id, :name, :email, :phone, :slack_id, :hipchat_id)
    end
end

