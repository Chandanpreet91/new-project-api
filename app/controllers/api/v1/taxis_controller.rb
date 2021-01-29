class Api::V1::TaxisController < ApplicationController

    def index
        taxis = Taxi.order(created_at: :desc)
    end

    def show
        @taxi = Taxi.find(params[:id])
        render(json: @taxi)
      end
    
end
