class Api::V1::WelcomeController < ApplicationController
    
        def index
        output = { message: 'Welcome to Super Taxi App', status:200 }.to_json
        render :json => output
        end
        
end
