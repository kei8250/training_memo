class WorkoutsController < ApplicationController
  before_action :authenticate_user
  before_action :user_admin,{only: [:destroy, :edit, :update]}
  
  def index
    @workouts = Workout.all.page(params[:page]).per(15)
  end

  def show
    
    @workout = Workout.find(params[:id])
    @record = Record.new
  end
  
  def more
    @workout = Workout.find(params[:id])
  end

  def new
    @workout = Workout.new
  end
  
  def create
    @workout = Workout.new(workout_params)
    if @workout.save
      redirect_to root_path, notice: '保存しました'
    else
      flash[:alert] = '保存できませんでした'
      render :new
    end
  end

  def edit
    @workout = Workout.find(params[:id])
  end
  def update
    @workout = Workout.find(params[:id])
    if @workout.update(workout_params)
      redirect_to root_path, notice: '保存しました'
    else
      flash[:alert] = '保存できませんでした'
      render :edit
    end
  end
  
  def destroy
    @workout = Workout.find(params[:id])
    @workout.destroy
    redirect_to root_path, notice: '削除しました'
  end

  def day
    @user = @current_user.id
    @records = Record.where(user_id: @user)
  end
  
  def search
    if params[:name].present?
      @workouts = Workout.where('name LIKE ?', "%#{params[:name]}%")
    else
      @workouts = Workout.none
    end
  end
  
 
  
  private
    def workout_params
        params.require(:workout).permit(:name, :part)
    end
end

