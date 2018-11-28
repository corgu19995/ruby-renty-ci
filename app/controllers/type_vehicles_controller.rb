class TypeVehiclesController < ApplicationController
    before_action :set_typevehicle, only: [:show, :update, :destroy]

    # GET /typevehicles
    def index
        @typevehicles = TypeVehicle.all
        json_response(@typevehicles)
    end
   
    # POST /typevehicles
    def create
        @typevehicle = TypeVehicle.create!(typevehicle_params)
        json_response(@typevehicle, :created)
    end

    # GET /typevehicles/:id
    def show
        json_response(@typevehicle)
    end

    # PUT /typevehicles/:id
    def update
        @typevehicle.update(typevehicle_params)
        head :no_content
    end

    # DELETE /typevehicles/:id
    def destroy
        @typevehicle.destroy
        head :no_content
    end

    def set_typevehicle
        @typevehicle = TypeVehicle.find(params[:id])
    end

    private
    
    def typevehicle_params
        # whitelist params
        params.permit(:name)
    end
end
