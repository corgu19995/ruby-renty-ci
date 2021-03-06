require 'json'
class BookingsController < ApplicationController

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
            params[:car_id]=params[:carId]
            params[:bookingdate]=params[:bookingDate]
            params[:pickupdate]=params[:pickupDate]
            params[:deliverplace]=params[:deliverPlace]
            params[:deliverdate]=params[:deliverDate]
            @bookings=Booking.all
            @bookings=@bookings.where(" ((pickupdate between date(:pickupDate) and date(:deliverDate)) or  (deliverdate between date(:pickupDate) and date(:deliverDate)) or 
                                        (date(:pickupDate) between pickupdate and deliverdate) or (date(:deliverDate) between pickupdate and deliverdate)) and
                                        car_id=:carId",
                                        {pickupDate:params[:pickupDate],deliverDate:params[:deliverDate],carId:params[:carId]})      
            
            if @bookings.empty?
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
        validateToken=ValidateToken.new
        localId=validateToken.firebase(params[:id])
        if localId.blank?
            data = JSON.parse('{"message":"Token no valido"}')
            json_response(data)
        else
            @bookings = Booking
                        .select("bookings.id as bookings_id,
                            bookings.bookingDate,
                            bookings.pickup,
                            bookings.pickupDate,
                            bookings.deliverPlace,
                            bookings.deliverDate,
                            cars.id as car_id,
                            cars.brand,
                            cars.model,
                            cars.thumbnail,
                            cars.price,
                            rentals.id as rental_id,
                            rentals.name as rental_name,
                            type_vehicles.name as type_vehicles_name")                    
                        .joins("INNER JOIN cars on cars.id=bookings.car_id")
                        .joins("INNER JOIN rentals on rentals.id=cars.rental_id")   
                        .joins("INNER JOIN type_vehicles on type_vehicles.id=cars.type_vehicle_id")
                        .where("bookings.user=:user",{user:localId})
            
            cont=1
            response="["
            for booking in @bookings
                response += '
                            {
                                "bookingId":"'+booking["bookings_id"].to_s+'",
                                "uid":"'+localId+'",
                                "car":{
                                    "id":"'+booking["car_id"].to_s+'",
                                    "brand":"'+booking["brand"].to_s+'",
                                    "model":"'+booking["model"].to_s+'",
                                    "thumbnail":"'+booking["thumbnail"].to_s+'",
                                    "price":"'+booking["price"].to_s+'",
                                    "type":"'+booking["type_vehicles_name"].to_s+'"
                                },
                                "bookingDate":"'+booking["bookingDate"].to_s+'",
                                "pickup":"'+booking["pickup"].to_s+'",
                                "pickupDate":"'+booking["pickupDate"].to_s+'",
                                "deliverPlace":"'+booking["deliverPlace"].to_s+'",
                                "deliverDate":"'+booking["deliverDate"].to_s+'",
                                "rental":{
                                    "id":"'+booking["rental_id"].to_s+'",
                                    "name":"'+booking["rental_name"].to_s+'"
                                }
                            }'
                if cont<@bookings.length
                    response +=","
                end
                cont =cont+1                            
            end  
            response +="]"          
            json_response(response)
        end
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
            @bookings= Booking
                        .select("bookings.id as bookings_id,
                            bookings.bookingDate,
                            bookings.pickup,
                            bookings.pickupDate,
                            bookings.deliverPlace,
                            bookings.deliverDate,
                            cars.id as car_id,
                            cars.brand,
                            cars.model,
                            cars.thumbnail,
                            cars.price,
                            rentals.id as rental_id,
                            rentals.name as rental_name,
                            type_vehicles.name as type_vehicles_name")                    
                        .joins("INNER JOIN cars on cars.id=bookings.car_id")
                        .joins("INNER JOIN rentals on rentals.id=cars.rental_id")   
                        .joins("INNER JOIN type_vehicles on type_vehicles.id=cars.type_vehicle_id")
                        .where("bookings.user=:user and bookings.id=:bookingId",{user:localId,bookingId:params[:bookingId]})
            
            if @bookings.empty?
                data = JSON.parse('{"message":"Reserva no encontrada"}')
                json_response(data);  
            else
                @bookingAux = Booking.find(params[:bookingId])
                
                for booking in @bookings
                    @car=Car.find(booking["car_id"])
                    response = '[
                                    {
                                        "bookingId":"'+booking["bookings_id"].to_s+'",
                                        "uid":"'+localId+'",
                                        "car":{
                                            "id":"'+booking["car_id"].to_s+'",
                                            "brand":"'+booking["brand"].to_s+'",
                                            "model":"'+booking["model"].to_s+'",
                                            "thumbnail":"'+booking["thumbnail"].to_s+'",
                                            "price":"'+booking["price"].to_s+'",
                                            "type":"'+booking["type_vehicles_name"].to_s+'"
                                        },
                                        "bookingDate":"'+booking["bookingDate"].to_s+'",
                                        "pickup":"'+booking["pickup"].to_s+'",
                                        "pickupDate":"'+booking["pickupDate"].to_s+'",
                                        "deliverPlace":"'+booking["deliverPlace"].to_s+'",
                                        "deliverDate":"'+booking["deliverDate"].to_s+'",
                                        "rental":{
                                            "id":"'+booking["rental_id"].to_s+'",
                                            "name":"'+booking["rental_name"].to_s+'"
                                        }
                                    }
                                ]'
                    @bookingAux.destroy
                    break
                end
                
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
        params.permit(:user, :car_id, :bookingdate, :pickup, :pickupdate, :deliverplace, :deliverdate)
    end
end
