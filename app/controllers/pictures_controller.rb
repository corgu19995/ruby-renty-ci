class PicturesController < ApplicationController
    before_action :set_car
    before_action :set_car_picture, only: [:show, :update, :destroy]

    # GET /pictures
    def index
        @pictures = Picture.all
        json_response(@pictures)
    end

    # POST /pictures
    def create
        @car = Car.find(params[:car_id])
        @picture = Picture.create!(picture_params)
        json_response(@picture, :created)
    end

    # GET /pictures/:id
    def show
        json_response(@picture)
    end

    # PUT /pictures/:id
    def update
        @picture.update(picture_params)
        head :no_content
    end

    # DELETE /pictures/:id
    def destroy
        @picture.destroy
        head :no_content
    end

    private

    def picture_params
        # whitelist params
        params.permit(:url, :car_id)
    end

    def set_car
        #@car = Car.find(params[:car_id])
    end

    def set_user_car
        #@picture = @car.pictures.find_by!(id: params[:id]) if @car
    end
end
