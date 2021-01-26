class Api::V1::BookingsController < ApplicationController
    def create
        user = User.find_by(token: params[:user][:token])
        taxi = Taxi.find_by(id: params[:taxi][:id])
       

        booking = Booking.create(taxi_id: taxi.id, status: Booking::AVAILABLE, user_id: user.id)
        drivers = Driver.where("status = ? ", Driver::ACTIVE)


         if booking && drivers.present?
            render json: {message: "Thank you for booking,we will send you a taxi soon"}
         else
            render json: {message: "We do not have any driver. Try again in a few seconds"}
         end
    end

    
    def accept
          booking = Booking.find_by(id: params[:booking][:id])
        
          user = User.find_by(token: params[:user][:token])
          driver = Driver.find_by(user_id: user.id)
          
        if booking && driver
          if booking.status != Booking::CLOSED
            update_status(booking, driver)
            push_status_to_user(booking, driver)
            render json: {message: "Proceed to pickup location"}
          else
            render json: {message: "Another driver is on the way"}
          end
        else
          render json: {error: "Unauthorized"}, status: 404
        end
    end

    def start_ride
        user = User.find_by(token: params[:user][:token])
        driver = Driver.find_by(user_id: user.id)
        driver.status = Driver::TRANSIT
        driver.save
        render json: {status: "Status updated to #{driver.status}"}
    end

    def reject 
        user = User.find_by(token: params[:user][:token])
        driver = Driver.find_by(user_id: user.id)
        booking = Booking.find(params[:booking][:id])
        driver.status = Driver::ACTIVE
        push_to_next_driver(driver, booking)
    end

    def invoice 
        booking = Booking.find(params[:booking][:id])
        render json: {
            pickup:booking.pickup_location,
            dropoff:booking.dropoff_location,
            time = booking.booked_time,

         }
    end


    def all_invoice
        user = User.find_by(token: params[:user][:token])
        driver = Driver.find_by(user_id: user.id)
        if driver
          bookings = Bookings.where("driver_id = ?", driver.id)
          render json: bookings
        end
      end

      def end_ride
        
          user = User.find_by(token: params[:user][:token])
          driver = Driver.find_by(user_id: user.id)
          driver.status = Driver::ACTIVE
          driver.save
          render json: {status: "Status updated to #{driver.status}"}
      
      end

      private 

      def update_status(booking, driver)
        booking.status = Booking::CLOSED
        booking.driver_id = driver.id
        driver.status = Driver::BUSY
        booking.save && driver.save
      end

      def push_status_to_user(booking, driver)
        Pusher.trigger("user_#{booking.user_id}", 'pickup', {
          message: "Your taxi is enroute",
          model: booking.taxi.model,
          make:  booking.taxi.make,          
          license_plate: booking.license_plate
        })
      end
end
