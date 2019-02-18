class Station
  attr_accessor :trains, :name

  def initialize(name)
    @name = name
    @trains = []
    puts "Сегодня была открыта станция #{name}"
  end

  def add_train(train)
    puts "Поезд с серийным номером #{train.serial} прибыл на станцию #{@name}"
    @trains << train
    train.station = self
  end

  def show_trains
    puts "Поезда на станции #{@name}:"
    @trains.each { |train| puts "Поезд с серийным номером #{train.serial}" }
  end

  def trains_by_type
    freight = 0
    passenger = 0
    @trains.each { |train| train.is_freight ? freight += 1 : passenger += 1 }
    puts "Пассажирских #{passenger} Грузовых #{freight}"
    { freights: freight, passengers: passenger }
  end

  def move_train(train)
    puts "Поезд с серийным номером #{train.serial} покидает станцию #{@name}"
    @trains.delete(train)
    train.move_forward if train.route
  end
end

class Route
  attr_reader :stations

  def initialize(start_point, finish_point)
    @stations = [start_point, finish_point]
    puts "Создан маршрут из #{start_point.name} в #{finish_point.name}"
  end

  def add_intermediate(station)
    puts "Станция #{station.name} добавлена в маршрут следования"
    @stations.insert(-2, station)
  end

  def delete_intermediate(station)
    puts "Станция #{station.name} убрана из маршрута следования"
    @stations.delete(station) if @stations.include?(station)
  end

  def show_route
    puts 'Ключевые точки в пути:'
    @stations.each { |station| puts station.name }
  end
end

class Train
  attr_accessor :carriages, :speed, :serial, :is_freight, :route, :station

  def initialize(serial, is_freight, carriages)
    @serial = serial
    @is_freight = is_freight
    @carriages = carriages
    @speed = 0
    puts "Сегодня был построен и выпущен поезд #{serial}"
  end

  def stop
    puts "Поезд #{@serial} остановлен"
    @speed = 0
  end

  def increase_speed(num = 10)
    puts "Скорость увеличена на #{num}, текущая скорость #{@speed} "
    @speed += num
  end

  def add_carriage
    stop
    puts 'Поезд остановлен для добавления вагона в состав'
    @carriages += 1
  end

  def remove_carriage
    stop
    puts 'Поезд остановлен для удаления вагона из состава'
    @carriages -= 1
  end

  def add_route(route)
    @route = route
    @station = @route.stations[0]
    @station.add_train(self)
  end

  def move_forward
    i = @route.stations.index(@station)
    if i == (@route.stations.size - 1)
      puts 'Поезд уже на конечной станции'
    else
      puts "Поезд перемещён к следующей станции #{@station.name}"
      @station = @route.stations[i + 1]
      @station.add_train(self)
    end
  end

  def move_back
    i = @route.stations.index(@station)
    if i.zero?
      puts 'Поезд на первой станции'
    else
      puts "Поезд перемещён к предыдущей станции #{@station.name}"
      @station = @route.stations[i - 1]
      @station.add_train(self)
    end
  end

  def previous_station
    if @route
      i = @route.stations.index(@station)
      if i > 0
        puts "Предыдущая станция #{@serial} #{@route.stations[i - 1].name}"
        @route.stations[i - 1]
      else
        puts 'Поезд находится на самой первой станции'
      end
    else
      puts 'У поезда не задан маршрут'
    end
  end

  def next_station
    if @route
      i = @route.stations.index(@station)
      if i < (@route.stations.size - 1)
        puts "Следующая станция #{@serial} #{@route.stations[i + 1].name}"
        @route.stations[i + 1]
      else
        puts 'Поезд находится на последней станции'
      end
    else
      puts 'У поезда не задан маршрут'
    end
  end
end
