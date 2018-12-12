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
        validateToken=ValidateToken.new
        response=validateToken.firebase(params[:token])
        if response.blank?
            data = JSON.parse('{"res":"Token no valido"}')
            json_response(data)
        else
            @bookings=Booking.all
            @bookings=@bookings.where(" ((pickupDate between date(:pickupDate) and date(:deliverDate)) or  (deliverDate between date(:pickupDate) and date(:deliverDate)) or 
                                        (date(:pickupDate) between pickupDate and deliverDate) or (date(:deliverDate) between pickupDate and deliverDate)) and
                                        car_id=:carId",
                                        {pickupDate:params[:pickupDate],deliverDate:params[:deliverDate],carId:params[:carId]})      
            
            if @bookings.blank?
                params[:car_id]=params[:carId]
                @car=Car.find(params[:carId])
                @user =User.find(params[:user_id])
                @booking = Booking.create!(booking_params)
                json_response(@booking, :created)
            else            
                data = JSON.parse('{"res":"Vehículo no disponible para las fechas seleccionadas"}')
                json_response(data)
            end        
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
        data = JSON.parse('{"message":"Your booking has been deleted with success!"}')
        json_response(data)
        #head :no_content
    end

    def set_booking
        print(params[:id]+"\n")
        @booking = Booking.find(params[:id])
    end

    private

    def booking_params
        # whitelist params
        params.permit(:token, :user_id, :car_id, :bookingDate, :pickup, :pickupDate, :deliverPlace, :deliverDate)
    end
end
