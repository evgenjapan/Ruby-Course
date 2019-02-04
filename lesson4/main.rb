require_relative 'train'
require_relative 'carriage'
require_relative 'route'
require_relative 'station'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_train'
require_relative 'passenger_train'

def init_interface
  loop do
    puts '1. Создать станцию'
    puts '2. Создать поезд'
    puts '3. Создать маршрут'
    puts '4. Добавить станцию к маршруту'
    puts '5. Убрать станцию из маршрута'
    puts '6. Назначить маршрут для поезда'
    puts '7. Создать вагон'
    puts '8. Изменить состав вагона'
    puts '9. Переместить поезд'
    puts '10. Показать список станций'
    puts '11. Показать список поездов'
    puts '12. Показать список поездов на станции'
    puts 'Для выхода введите "exit"'
    val = gets.chomp
    break if val == 'exit'
    choice(val.to_i)
  end
end

def choice(value)
  case value
  when 1 then create_station
  when 2 then create_train
  when 3 then create_route
  when 4 then add_station
  when 5 then delete_station
  when 6 then add_route
  when 7 then create_carriage
  when 8 then train_change
  when 9 then move_train
  when 10 then show_stations
  when 11 then show_trains
  when 12 then show_trains_on_station
  else return
  end
end

@stations = []
@trains = []
@routes = []
@carriages = []

def create_station
  puts "Название станции"
  name = gets.chomp
  @stations << Station.new(name)
end

ERROR = 'Похоже что-то пошло не так'

def create_train
  puts '1. Пассажирский поезд'
  puts '2. Грузовой поезд'
  type = gets.to_i
  puts 'Введите название поезда'
  serial = gets.chomp
  return @trains << PassengerTrain.new(serial) if type == 1
  return @trains << CargoTrain.new(serial) if type == 2
  puts ERROR
end

def create_route
  return puts 'Слишком мало станций, создайте еще' if @stations.size < 2
  puts 'Введите сначала порядковый номер первой станции, а затем конечной'
  first = gets.to_i - 1
  last = gets.to_i - 1
  return @routes << Route.new(@stations[first], @stations[last]) if @stations[first] and @stations[last]
  puts ERROR
end

def add_station
  puts 'Введите порядковый номер маршрута'
  index_route = gets.to_i - 1
  return puts 'Нет доступных маршрутов' if @routes.size == 0
  return puts 'Нет такого маршрута' unless @routes[index_route]
  puts 'Введите порядковый номер станции'
  index_station = gets.to_i - 1
  return @routes[index_route].add_intermediate(@stations[index_station]) if @stations[index_station]
  puts ERROR
end

def delete_station
  puts 'Введите порядковый номер маршрута'
  index_route = gets.to_i - 1
  return puts 'Нет доступных маршрутов' if @routes.size == 0
  return puts 'Нет такого маршрута' unless @routes[index_route]
  puts 'Введите порядковый номер станции'
  index_station = gets.to_i - 1
  return @routes[index_route].delete_intermediate(@stations[index_station]) if @stations[index_station]
  puts ERROR
end

def add_route
  puts 'Введите порядковый номер поезда, а затем порядковый номер маршрута'
  index_train = gets.to_i - 1
  index_route = gets.to_i - 1
  return puts 'Нет доступных маршрутов' if @routes.size == 0
  return puts 'Нет такого маршрута' unless @routes[index_route]
  return @trains[index_train].add_route(@routes[index_route]) if @trains[index_train]
  puts ERROR
end

def create_carriage
  puts '1. Грузовой'
  puts '2. Пассажирский'
  type = gets.to_i
  return @carriages << PassengerCarriage.new if type == 2
  return @carriages << CargoCarriage.new if type == 1
  puts ERROR
end

def train_change
  puts '1. Прицепить вагон'
  puts '2. Отцепить вагон'
  val = gets.to_i
  puts 'Введите сначала порядковый номер вагона, а затем порядковый номер поезда'
  index_carriage = gets.to_i - 1
  index_train = gets.to_i - 1
  if @trains[index_train] and @carriages[index_carriage]
    return @trains[index_train].add_carriage(@carriages[index_carriage]) if val == 1
    return @trains[index_train].remove_carriage(@carriages[index_carriage]) if val == 2
  end
  puts ERROR
end

def move_train
  puts 'Введите порядковый номер поезда'
  index_train = gets.to_i - 1
  return puts 'Поезд не существует' unless @trains[index_train]
  return puts 'У поезда не задан маршрут' unless @trains[index_train].route
  puts '1. Двигаться вперёд'
  puts '2. Вернуться назад'
  val = gets.to_i
  return @trains[index_train].move_forward if val == 1
  return @trains[index_train].move_back if val == 2
  puts ERROR
end

def show_stations
  @stations.each_with_index {|station, i| puts "#{station.name} Номер: #{i + 1}" }
end

def show_trains
  @trains.each_with_index {|train, i| puts "#{train.serial} Номер: #{i + 1}" }
end

def show_trains_on_station
  puts 'Введите порядковый номер станции'
  index_station = gets.to_i
  return @station[index_station].show_trains if @stations[index_station]
  puts ERROR
end

init_interface
