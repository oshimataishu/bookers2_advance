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
    @user = User.find(params[:id])
    @group = Group.find(params[:id])
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
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