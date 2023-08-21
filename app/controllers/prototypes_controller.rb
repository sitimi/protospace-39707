class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:edit, :show, :update]

  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to '/'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
 
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    move_to_index
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to action: :show
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to '/'
  end

  private

  def prototype_params
    params.require(:prototype).permit(:image, :title, :catch_copy, :concept).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    unless current_user.id == @prototype.user.id
      redirect_to action: :index
    end
  end

end
