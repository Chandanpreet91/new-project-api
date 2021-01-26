# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




Taxi.destroy_all

User.destroy_all
PASSWORD='supersecret'

super_user=User.create(
    first_name: 'Jon',
    last_name: 'Snow',
    email:"js@winterfell.gov",
    password: PASSWORD,
    is_admin: true
)
10.times do 
first_name=Faker::Name.first_name
last_name=Faker::Name.last_name
User.create(
    first_name:first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: PASSWORD
)
end
users=User.all



100.times do
    # 👇🏻This will generate Random date in the past(Up to maximum of N days)
    created_at = Faker::Date.backward(days:365*5)

    Taxi.create(
        license_plate: Faker::Vehicle.license_plate,
        make: Faker::Vehicle.make,
        model: Faker::Vehicle.model,
        longitude: Faker::Address.longitude,
        latitude: Faker::Address.latitude,
        driver: Faker::Name.unique.name,
        created_at:created_at,
        updated_at:created_at
        )

end
taxis =Taxi.all

taxis.each do |t|
    t.users = users.shuffle.slice(0,rand(users.count))
end
users.each do |u|
    u.booked_taxis = taxis.shuffle.slice(0,rand(taxis.count))
end



puts Cowsay.say("Generated #{taxis.count} taxis", :frogs)
puts Cowsay.say("Generated #{users.count} users", :beavis)
puts Cowsay.say("Login with #{super_user.email} and password: #{PASSWORD}", :koala)
puts Cowsay.say("Generated #{Booking.count} bookings for taxi", :bunny)
