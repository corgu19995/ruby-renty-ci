require 'json'
class BookingsController < ApplicationController
    before_action :set_booking, only: [:show, :update]
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
            data = JSON.parse('{"message":"Token no valido"}')
            json_response(data)
        else
            @bookings=Booking.all
            @bookings=@bookings.where(" ((pickupDate between date(:pickupDate) and date(:deliverDate)) or  (deliverDate between date(:pickupDate) and date(:deliverDate)) or 
                                        (date(:pickupDate) between pickupDate and deliverDate) or (date(:deliverDate) between pickupDate and deliverDate)) and
                                        car_id=:carId",
                                        {pickupDate:params[:pickupDate],deliverDate:params[:deliverDate],carId:params[:carId]})      
            
            if @bookings.blank?
                params[:car_id]=params[:carId]
                params[:user]=response
                @car=Car.find(params[:carId])
                @booking = Booking.create!(booking_params)
                data = JSON.parse('{"message":"Booking realizada correctamente"}')
                json_response(data)
            else            
                data = JSON.parse('{"message":"Vehículo no disponible para las fechas seleccionadas"}')
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
        @booking = Booking.find(params[:id])
        @booking.destroy
        data = JSON.parse('{"message":"Your booking has been deleted with success!"}')
        json_response(data)
        #head :no_content
    end

    def cancelarBookings
        validateToken=ValidateToken.new
        localId=validateToken.firebase(params[:token])
        if localId.blank?
            data = JSON.parse('{"message":"Token no valido"}')
            json_response(data)
        else
            @booking = Booking
                        .select("bookings.*,
                            cars.id as car_id,
                            cars.*,
                            rentals.id as rental_id,
                            rentals.name as rental_name,
                            type_vehicles.name as type_vehicles_name")                    
                        .joins("INNER JOIN cars on cars.id=bookings.car_id")
                        .joins("INNER JOIN rentals on rentals.id=cars.rental_id")   
                        .joins("INNER JOIN type_vehicles on type_vehicles.id=cars.type_vehicle_id")
                        .where("bookings.user=:user and bookings.id=:bookingId",{user:localId,bookingId:params[:bookingId]})
                        .take
            
            if @booking.blank?
                data = JSON.parse('{"message":"Reserva no encontrada"}')
                json_response(data);  
            else
                @bookingAux = Booking.find(params[:bookingId])
                @bookingAux.destroy
                @car=Car.find(@booking["car_id"])
                response = '[
                                {
                                    "bookingId":"'+@booking["id"].to_s+'",
                                    "uid":"'+localId+'",
                                    "car":{
                                        "id":"'+@booking["car_id"].to_s+'",
                                        "brand":"'+@booking["brand"].to_s+'",
                                        "model":"'+@booking["model"].to_s+'",
                                        "thumbnail":"'+@booking["thumbnail"].to_s+'",
                                        "price":"'+@booking["price"].to_s+'",
                                        "type":"'+@booking["type_vehicles_name"].to_s+'"
                                    },
                                    "bookingDate":"'+@booking["bookingDate"].to_s+'",
                                    "pickup":"'+@booking["bookingDate"].to_s+'",
                                    "pickupDate":"'+@booking["bookingDate"].to_s+'",
                                    "deliverPlace":"'+@booking["bookingDate"].to_s+'",
                                    "deliverDate":"'+@booking["bookingDate"].to_s+'",
                                    "rental":{
                                        "id":"'+@booking["rental_id"].to_s+'",
                                        "name":"'+@booking["rental_name"].to_s+'"
                                    }
                                }
                            ]'
                            
                json_response(JSON.parse(response))
            end
        end
    end

    def set_booking
        @booking = Booking.where("user=:id",params[:id])
    end

    private

    def booking_params
        # whitelist params
        params.permit(:user, :car_id, :bookingDate, :pickup, :pickupDate, :deliverPlace, :deliverDate)
    end
end
