class UserGroupsController < ApplicationController
  before_action :authenticate_user!

  def create
    @group = Group.find(params[:group_id])
    if UserGroup.create(user_id: current_user.id, group_id: @group.id)
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @user_group = UserGroup.find_by(user_id: current_user.id, group_id: @group.id)
    @user_group.destroy
    redirect_to request.referer
  end
end
