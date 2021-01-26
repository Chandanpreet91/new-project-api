class DriversController < ApplicationController
   
    def login  
      user = User.find_by(email: params[:user][:email])
      if user
        driver = Driver.find_by(user_id: user.id)
        if driver
          render json: {data: {user: user, driver: driver}}, status: 200
        else
          render json: {error: 'Driver does not exist'}, status: 404
        end
      else
        render json: { error: 'Invalid Username and/or Password'}, status: 404
      end
    end

    def logout
        user = User.find_by(token: params[:user][:token])
        driver = Driver.find_by(user_id: user.id)
        if driver
          driver.status = Driver::INACTIVE
          driver.save
        else
          render json: {error: 'Driver does not exist'}, status: 404
        end
        session[:current_user_id] = nil
        render json: { message: "successfully logged out!"}, status: 200
    end

    def update 
        user = User.find_by(token: params[:user][:token])
        if user
            driver = Driver.find_by(user_id: user.id)
            if driver
              user.first_name = params[:user][:first_name]
              user.last_name = params[:user][:last_name]
              user.save
              driver.save
              render json: { status: 'success'}, status: 200
            else
                render json: {error: 'We could not find a registered driver account'}, status: 404
            end
        else
            render json: {error: 'No registered user'}, status: 404
        end
    end

    def status
        user = User.find_by(token: params[:user][:token])
        if user
          driver = Driver.find_by(user_id: user.id)
          if driver
            new_status = set_status(params[:driver][:status])
            if new_status.nil?
              render json: { error: 'Unknown status was provided' }, status: 200
            else
              if driver.save
                render json: { status: 'success' }, status: 200
              else
                render json: { error: 'Something went wrong while we tried to update your status, please try again' }, status: 200
              end
            end
          else
            render json: {error: 'Details could not be loaded'}, status: 404
          end
        else
          render json: { error: 'You are not authorized to perform this action' }, status: 404
        end
  
    end

    private
    def set_status(status)
      status = status.capitalize
      if status == Driver::ACTIVE
        Driver::ACTIVE
      elsif status == Driver::BUSY
        Driver::BUSY
      elsif status == Driver::TRANSIT
        Driver::TRANSIT
      elsif status == Driver::INACTIVE
        Driver::INACTIVE
      else
        NIL
      end
    end

end
