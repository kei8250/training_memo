class LikesController < ApplicationController
    before_action :authenticate_user
    def create
        @like = Like.new(user_id: @current_user.id, workout_id: params[:workout_id])
        @like.save
            
        redirect_to("/")
    end
    
    def destroy
        @like = Like.find_by(user_id: @current_user.id, workout_id: params[:workout_id])
        @like.destroy
    redirect_to("/")
    end
    
  
end