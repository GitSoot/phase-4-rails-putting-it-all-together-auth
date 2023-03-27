class SessionsController < ApplicationController
    def create
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        render json: @user, status: :ok
      elsif @user.nil?
        render json: { errors: ["Invalid username or password"] }, status: :unauthorized
      else
        render json: { errors: ["Invalid username or password"] }, status: :unauthorized
      end
    end
  
    def destroy
        if logged_in?
          session.delete(:user_id)
          head :no_content
        else
          render json: { error: 'You are not logged in' }, status: :unauthorized
        end
    end
      
end
  