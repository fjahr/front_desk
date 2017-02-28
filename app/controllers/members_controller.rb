class MembersController < InheritedResources::Base

  private

    def member_params
      params.require(:member).permit(:account_id, :name, :email, :phone, :slack_id, :hipchat_id)
    end
end

