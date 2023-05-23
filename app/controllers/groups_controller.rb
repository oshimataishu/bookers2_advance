class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @group = Group.new
  end

  def index
    @book = Book.new
    @groups = Group.all
  end

  def show
    @book = Book.new
    @user = current_user
    @group = Group.find(params[:id])
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      UserGroup.create(user_id: current_user.id, group_id: @group.id)
      redirect_to groups_path
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end

  def new_mail
    @group = Group.find(params[:group_id])
  end

  def send_mail
    @group = Group.find(params[:group_id])
    group_users = @group.users
    @mail_title = params[:mail_title]
    @mail_content = params[:mail_content]
    ContactMailer.send_mail(@group, @mail_title, @mail_content, group_users).deliver
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :owner_id, :group_image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.is_owned_by?(current_user)
      redirect_to groups_path
    end
  end
end
