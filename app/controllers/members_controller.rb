class MembersController < InheritedResources::Base
  def new
    @member = Member.new
    @member.aliases.build
  end

  def edit
    @member = Member.find_by(sequential_id: params[:id])
  end

  def show
    @member = current_user.account.members.find_by(sequential_id: params[:id])
  end

  def index
    @members = current_user.account.members.all
  end

  def create
    @member = current_account.members.new member_params

    nested_alias_names.each do |alias_name|
      @member.aliases.build(name: alias_name)
    end

    if @member.save
      redirect_to @member
    else
      render action: :new
    end
  end

  private

    def member_params
      params.require(:member).permit(:name, :email, :slack_id)
    end

    def nested_alias_names
      params["member"]["aliases_attributes"]["0"]["name"].split(",")
    end
end

