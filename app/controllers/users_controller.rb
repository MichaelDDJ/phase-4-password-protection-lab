class UsersController < ApplicationController


    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        current_user = User.find_by(id: session[:user_id])
        if current_user
            render json: current_user
        else
            render json: {error: "Not authorized"}, status: :unauthorized
        end
    end

    private

    def signup_error(invalid)
        render json: {error: "Invalid username or password"}, status: :unprocessable_entity
    end

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
#user = User.create!(user_params)
 #       session[:user_id] = user.id
  #      render json: user
