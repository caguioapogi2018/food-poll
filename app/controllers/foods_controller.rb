class FoodsController < ApplicationController
  before_action :food_id, only:[:show, :edit, :update, :destroy, :req_same_user]
  before_action :req_same_user, only:[ :edit, :destroy]

  def index
    @foods = Food.includes(:user).paginate(page:params[:page], per_page:6)
    # @foods = Food.paginate(page:params[:page], per_page:6)

  end

  def new
      @food = Food.new
  end

  def create
      @food = Food.create(food_params)
      @food.user_id = current_user.id
      if @food.save
        flash[:success] = "The food was successful saved"
        redirect_to root_path
      else
        render :new
      end
  end

  def show

  end

  def edit

  end


  def update
    if @food.update(food_params)
      flash[:success] = "The content was successfully updated"
      redirect_to root_path
    end
  end

  def destroy
    @food = food_id
    @food.user = current_user
    if @food.destroy
      flash[:success] = "The content was successfully deleted"
      redirect_to root_path
    end
  end

  private

  def food_params
    params.require(:food).permit(:title, :category, :description)
  end


  def food_id
    @food = Food.find(params[:id])
  end

  def req_same_user
    if current_user != @food.user
      flash[:warning] = "Restricted Access "
      redirect_to root_path
    end
  end



end