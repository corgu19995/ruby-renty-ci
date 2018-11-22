class RentalsController < ApplicationController
    before_action :set_rental, only: [:show, :update, :destroy]

    def index
        @rentals=Rental.all
        if params[:from].present? && params[:to].present? 
            @rentals=@rentals.where("created_at>=? and updated_at<=?",params[:from],params[:to])
        end
        json_response(@rentals)
    end

    def create
        @user=User.find(params[:user_id])
        @car =Car.find(params[:car_id])
        @rental=Rental.create!(rental_params)
        json_response(@rental, :created)
    end

    def rental_params
        params.permit(:name, :user_id, :car_id, :from, :to)
    end

    def set_rental
        @rental = Rental.find(params[:id])
    end

    def show
        json_response(@rental)
    end

    def update
        @rental.update(rental_params)
        head :no_content
    end

    def destroy
        @rental.destroy
        head :no_content
    end
end
