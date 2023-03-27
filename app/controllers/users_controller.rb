class UsersController < ApplicationController
    def create
        @user = User.new(user_params)
        if @user.save
          session[:user_id] = @user.id
          render json: @user, status: :created
        else
          puts "DEBUG: Failed to save user - errors: #{@user.errors}"
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

    def show
        if logged_in?
          render json: current_user, status: :ok
        else
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
      end
    
    private
    
    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation, :image_url, :bio) if params[:user].present?
    end
      

    def logged_in?
        !!current_user
    end

  end
  