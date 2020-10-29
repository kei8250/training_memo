class RecordsController < ApplicationController
  before_action :authenticate_user
  def create
    @workout = Workout.find(params[:workout_id])
    @record = Record.new(user_id: @current_user.id
    )
    if @record.update(record_params)
      redirect_to workout_path(@workout), notice: '保存できました'
    else
      redirect_to workout_path(@workout), alert: '保存できませんでした'
    end
    
  end
  def edit
    @workout = Workout.find(params[:workout_id])
    @record = @workout.records.find(params[:id])
  end
  
  def update
    @workout = Workout.find(params[:workout_id])
    @record = @workout.records.find(params[:id])
    if @record.update(record_params)
      redirect_to workout_path(@workout), notice: '更新しました'
    else
      flash[:alert] = '更新できませんでした'
      render :edit
    end
  end
  
  def destroy
    @workout = Workout.find(params[:workout_id])
    @record = @workout.records.find(params[:id])
    @record.destroy
    redirect_to workout_path(@workout), notice: '削除しました'
  end
  
  private
    def record_params
      params.require(:record).permit(:weight, :reps, :workout_id, :memo)
    end
end
