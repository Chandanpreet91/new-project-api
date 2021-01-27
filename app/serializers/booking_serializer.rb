class BookingSerializer < ActiveModel::Serializer

  attributes (
    :id, 
    :driver_id, 
    :taxi_id, 
    :user_id, 
    :pickup_location,
    :dropoff_location
  )


end
