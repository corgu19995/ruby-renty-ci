require 'json'
class BookingsController < ApplicationController
    before_action :set_booking, only: [:show, :update, :destroy]

    # GET /bookings
    def index
        @bookings = Booking.all
        json_response(@bookings)
    end
   
    # POST /bookings
    def create
        @bookings=Booking.all
        #@bookings=@bookings.where("[from] >=current_date and to <=current_date",params[:from],params[:to])      
        json_response(@bookings)  
        # if @booking.nil?
        #     data = JSON.parse('{"respuesta":"no se puede ingresar"}')
        #     json_response(data)
        # else
        #     @car=Car.find(params[:car_id])
        #     @user =User.find(params[:user_id])
        #     @booking = Booking.create!(booking_params)
        #     json_response(@booking, :created)
        # end        
        
    end

    # GET /bookings/:id
    def show
        json_response(@booking)
    end

    # PUT /bookings/:id
    def update
        @booking.update(booking_params)
        head :no_content
    end

    # DELETE /bookings/:id
    def destroy
        @booking.destroy
        head :no_content
    end

    def set_booking
        @booking = Booking.find(params[:id])
    end

    private

    def booking_params
        # whitelist params
        params.permit(:name, :user_id, :car_id, :from, :to)
    end
end
