require_relative 'oop'

puts 'Пример работы'

station_k = Station.new('Крюково')
station_s = Station.new('Саларьево')
station_r = Station.new('Речной вокзал')

train_a = Train.new('Атаман', false, 7)
train_g = Train.new('Груз200', true, 7)

route1 = Route.new(station_k, station_r)

route1.add_intermediate(station_s)
route1.show_route
route1.delete_intermediate(station_s)
route1.show_route

train_a.add_route(route1)
train_g.add_route(route1)

station_k.show_trains
station_k.trains_by_type
station_k.move_train(train_g)

train_g.move_back
train_g.move_forward

train_a.next_station
train_g.previous_station

train_g.stop
train_g.increase_speed
train_g.add_carriage
train_g.carriages
