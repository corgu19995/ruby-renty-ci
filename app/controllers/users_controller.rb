class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    #before_action :set_user_filter, only: [:index]

    # GET /users
    def index
        @users = User.all
        json_response(@users)
        #json_response(@user_filter)
    end
   
    # POST /users
    def create
        @user = User.create!(user_params)
        json_response(@user, :created)
    end

    # GET /users/:id
    def show
        json_response(@user)
    end

    # PUT /users/:id
    def update
        @user.update(user_params)
        head :no_content
    end

    # DELETE /users/:id
    def destroy
        @user.destroy
        head :no_content
    end

    private

    def user_params
        # whitelist params
        params.permit(:name)
    end

    def set_user
        @user = User.find(params[:id])
    end

    def set_user_filter
        #@user_filter = User.where(nil)
        #@user_filter = @user_filter.find_by!(name: params[:name]) if params[:name].present?
    end

end
