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
        @bookings=@bookings.where(" (([from] between date(:from) and date(:to)) or  ([to] between date(:from) and date(:to)) or 
                                    (date(:from) between [from] and [to]) or (date(:to) between [from] and [to])) and
                                    car_id=:car_id",
                                    {from:params[:from],to:params[:to],car_id:params[:car_id]})      
        
        if @bookings.blank?
            @car=Car.find(params[:car_id])
            @user =User.find(params[:user_id])
            @booking = Booking.create!(booking_params)
            json_response(@booking, :created)
        else            
            data = JSON.parse('{"res":"Vehículo no disponible para las fechas seleccionadas"}')
            json_response(data)
        end        
        
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
