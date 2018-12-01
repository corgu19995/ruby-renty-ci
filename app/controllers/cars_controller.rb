require 'json'
class CarsController < ApplicationController
    before_action :set_car, only: [:update, :destroy]
    
    def index
        @cars = Car.all
        json_response(@cars)
    end

    # GET /cars/search
    def search
        @cars = Car
                .select("   cars.id,
                            cars.brand,
                            cars.model,
                            cars.thumbnail,
                            cars.price,
                            type_vehicles.name as type,
                            cars.rental_id,
                            rentals.name
                            "
                        )
                .joins("INNER JOIN type_vehicles on type_vehicles.id=cars.id
                        INNER JOIN rentals on rentals.id=cars.rental_id")

        if params[:type].present?
            @cars=@cars.where("type=?",params[:type])
        end
        
        cont=1
        response='[';
        for car in @cars
            response +="{"
            response +='"id":"'+car.id.to_s+'",'
            response +='"brand":"'+car.brand.to_s+'",'
            response +='"model":"'+car.model.to_s+'",' 
            response +='"thumbnail":"'+car.thumbnail.to_s+'",'            
            response +='"price":"'+car.price.to_s+'",'
            response +='"type":"'+car.type.to_s+'",'                        
            response +='"rental":{"id":'+car.rental_id.to_s+',"name":"'+car.name.to_s+'"}'         
            response +='}'
            
            if cont<@cars.length
                response +=","
            end
            cont =cont+1
        end
        response +=']'
        data = JSON.parse(response)
        json_response(data)
    end
    
    def create
        @typevehicle=TypeVehicle.find(params[:type_vehicle_id])
        @rental =Rental.find(params[:rental_id])
        @car = Car.create!(car_params)
        json_response(@car, :created)
    end

    # GET /cars/:id
    def show
        @car = Car
                .select('cars.*')
                .where('cars.id=?',params[:id])
        @rentals = Rental
                    .where('car_id=?',params[:id])   
                    .take(1)
        @pictures = Picture
                    .where('car_id=?',params[:id])
        
        #@car['rental']=@rentals[0]
        #result=@car.ensure_array
        #result={'car'=>[@car,{'rental'=>@rentals[0],"pictures"=>@pictures}]}        
        #json_response(result)

        response='{';
        for car in @car
            response +='"id":"'+car.id.to_s+'",'
            response +='"brand":"'+car.brand.to_s+'",'
            response +='"thumbnail":"'+car.thumbnail.to_s+'",'            
            response +='"price":"'+car.price.to_s+'",'
            response +='"type":"'+car.type.to_s+'",'
            response +='"model":"'+car.model.to_s+'",'            
            response +='"rental":{"id":123456789,"name":"Ruby"'
            # for rental in @rentals
            #     response +='"id":"'+rental.id.to_s+'","name":"'+rental.name.to_s+'"'
            #     break  
            # end
            response +='},'
            response +='"plate":"'+car.plate.to_s+'",'
            response +='"rating":"'+car.rating.to_s+'",'
            response +='"capacity":"'+car.capacity.to_s+'",'
            response +='"transmission":"'+car.transmission.to_s+'",'
            response +='"doors":"'+car.doors.to_s+'",'
            response +='"color":"'+car.color.to_s+'",'
            response +='"kms":"'+car.kms.to_s+'",'

            response +='"pictures":['
            cont = 1
            for pictures in @pictures
                response +='"'+pictures.url.to_s+'"'
                if cont<@pictures.length
                    response +=','
                end
                cont = cont+1
            end
            response +=']'

            break
        end
        response +='}'
        data = JSON.parse(response)
        json_response(data)
    end

    # PUT /cars/:id
    def update
        @car.update(car_params)
        head :no_content
    end

    # DELETE /cars/:id
    def destroy
        @car.destroy
        head :no_content
    end

    private

    def car_params
        # whitelist params
        params.permit(:brand, :thumbnail, :price, :type, :model, :plate, :rating, :capacity, :transmission, :doors, :color, :kms, :pickup, :rental_id, :type_vehicle_id)
    end

    def set_car
        @car = Car.find(params[:id])
    end

end
