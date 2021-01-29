class TaxiSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :make,
    :model,
    :license_plate
  )
end
