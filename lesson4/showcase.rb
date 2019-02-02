require_relative 'train'
require_relative 'carriage'
require_relative 'route'
require_relative 'station'

puts "Пример работы"

station_k = Station.new('Крюково')
station_s = Station.new('Саларьево')
station_r = Station.new('Речной вокзал')

train_a = CargoTrain.new('Атаман')
train_g = PassengerTrain.new('Груз200')

carriage_a = CargoCarriage.new
carriage_b = PassengerCarriage.new

route1 = Route.new(station_k, station_r)

route1.add_intermediate(station_s)
route1.show_route
route1.delete_intermediate(station_s)
route1.show_route

train_a.add_route(route1)
train_g.add_route(route1)

station_k.show_trains
station_k.get_trains_by_type
station_k.move_train(train_g)

train_g.move_back
train_g.move_forward

train_a.next_station
train_g.previous_station

train_g.stop
train_g.increase_speed
train_g.add_carriage(carriage_b)
train_g.carriages
