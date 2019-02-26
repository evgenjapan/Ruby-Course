require_relative 'train'
require_relative 'carriage'
require_relative 'route'
require_relative 'station'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'manufacturer'
require_relative 'instance_counter'

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
    puts '13. Показать список вагонов в поезде'
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
  when 13 then show_carriages_in_train
  else false
  end
end

@stations = []
@trains = []
@routes = []
@carriages = []

def create_station
  puts 'Название станции'
  name = gets.chomp
  @stations << Station.new(name)
rescue StandardError => e
  puts e.message
  retry
end

ERROR = 'Похоже что-то пошло не так'.freeze

def create_train
  puts 'Введите название поезда'
  serial = gets.chomp
  puts '1. Пассажирский поезд'
  puts '2. Грузовой поезд'
  type = gets.to_i
  raise '1 или 2, всё ведь написано' if (type != 1) && (type != 2)

  case type
  when 1 then @trains << PassengerTrain.new(serial)
  when 2 then @trains << CargoTrain.new(serial)
  else create_train
  end
rescue StandardError => e
  puts e.message
end

def create_route
  raise 'Слишком мало станций, создайте еще' if @stations.size < 2

  puts 'Введите сначала порядковый номер первой станции, а затем конечной'
  first = choice_station
  last = choice_station
  @routes << Route.new(first, last)
rescue StandardError => e
  puts e.message
  retry
end

def add_station
  route = choice_route
  station = choice_station
  route.add_intermediate(station)
rescue StandardError => e
  puts e.message
  retry
end

def delete_station
  route = choice_route
  station = choice_station
  route.delete_intermediate(station)
rescue StandardError => e
  puts e.message
  retry
end

def add_route
  puts 'Введите порядковый номер поезда, а затем порядковый номер маршрута'
  train = choice_train
  route = choice_route
  train.add_route(route)
end

def create_carriage
  puts '1. Грузовой'
  puts '2. Пассажирский'
  type = gets.to_i
  raise '1 или 2, всё ведь написано' if (type != 1) && (type != 2)

  if type == 1
    puts 'Введите объем грузового вагона'
    volume = gets.to_i
    @carriages << CargoCarriage.new(volume)
  else
    puts 'Введите кол-во мест в вагоне'
    tickets = gets.to_i
    @carriages << PassengerCarriage.new(tickets)
  end
rescue StandardError => e
  puts e.message
end

def train_change
  puts '1. Прицепить вагон'
  puts '2. Отцепить вагон'
  val = gets.to_i
  puts 'Введите порядковый номер вагона'
  index_carriage = gets.to_i - 1
  train = choice_train
  if @carriages[index_carriage]
    return train.add_carriage(@carriages[index_carriage]) if val == 1
    return train.remove_carriage(@carriages[index_carriage]) if val == 2
  end
  puts ERROR
end

def move_train
  train = choice_train
  raise 'У поезда не задан маршрут' unless train.route

  puts '1. Двигаться вперёд'
  puts '2. Вернуться назад'
  val = gets.to_i
  return train.move_forward if val == 1
  return train.move_back if val == 2

  puts ERROR
end

def show_stations
  @stations.each_with_index { |station, i| puts "#{station.name} #{i + 1}" }
end

def show_trains
  @trains.each_with_index { |train, i| puts "#{train.serial} Номер: #{i + 1}" }
end

def show_trains_on_station
  station = choice_station
  station.each_train { |train, i| puts "#{i + 1}. #{train.serial}" }
end

def show_carriages_in_train
  train = choice_station
  if train.type == :cargo
    train.each_carriage do |i, c|
      puts "#{i + 1}: Грузовой #{c.free_volume}/#{c.taken_volume}"
    end
  else
    train.each_carriage do |i, c|
      puts "#{i + 1}: Пассажирский #{c.free_seats}/#{c.taken_seats}"
    end
  end
end

def choice_train
  puts 'Введите порядковый номер поезда'
  index_train = gets.to_i - 1
  raise 'Порядковый номер должен быть числом' unless index_train.is_a? Integer
  raise 'Порядковый номер не может быть меньше 1' if index_train < 0
  raise 'Поезд не существует' unless @trains[index_train]

  @trains[index_train]
end

def choice_station
  puts 'Введите порядковый номер станции'
  index_station = gets.to_i - 1
  raise 'Порядковый номер должен быть числом' unless index_station.is_a? Integer
  raise 'Порядковый номер не может быть меньше 1' if index_station < 0
  raise 'Станция не существует' unless @stations[index_station]

  @stations[index_station]
end

def choice_route
  raise 'Нет доступных маршрутов' if @routes.empty?

  puts 'Введите порядковый номер маршрута'
  index_route = gets.to_i - 1
  raise 'Порядковый номер должен быть числом' unless index_route.is_a? Integer
  raise 'Порядковый номер не может быть меньше 1' if index_route < 0
  raise 'Маршрут не существует' unless @routes[index_route]

  @routes[index_route]
end

init_interface
