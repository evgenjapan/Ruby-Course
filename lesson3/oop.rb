class Station
  attr_accessor :trains, :name

  def initialize(name)
    @name = name
    @trains = []
    puts "Сегодня была открыта станция #{name}"
  end

  def add_train(train)
    @trains << train
    train.station = self
    puts "Поезд с серийным номером #{train.serial} прибыл на станцию #{@name}"
  end

  def show_trains
    puts "Поезда на станции #{@name}:"
    @trains.each {|train| puts "Поезд с серийным номером #{train.serial}" }
  end

  def get_trains_by_type
    freight = 0
    passenger = 0
    @trains.each do |train|
      if train.is_freight
        freight += 1
      else
        passenger += 1
      end
    end
    puts "Пассажирских #{passenger} Грузовых #{freight} - поездов на станции #{@name}"
  end

  def move_train(train)
    @trains.delete(train)
    puts "Поезд с серийным номером #{train.serial} покидает станцию #{@name}"
    train.move_forward  if train.route
  end

end

class Route
  attr_reader :route

  def initialize(start_point, finish_point)
    @route = [start_point, finish_point]
    puts "Создан маршрут из #{start_point.name} в #{finish_point.name}"
  end

  def add_intermediate(station)
    @route.insert(-2, station)
    puts "Станция #{station.name} добавлена в маршрут следования"
  end

  def delete_intermediate(station)
    @route.delete(station) if @route.include?(station)
    puts "Станция #{station.name} убрана из маршрута следования"
  end

  def show_route
    puts "Ключевые точки в пути:"
    @route.each {|station| puts station.name}
  end

end

class Train
  attr_accessor :carriages, :speed, :serial, :is_freight, :route, :station

  def initialize(speed = 0, serial, is_freight, carriages)
    @serial = serial
    @is_freight = is_freight
    @carriages = carriages
    @speed = speed
    puts "Сегодня был построен и выпущен поезд #{serial}"

  end

  def stop
    @speed = 0
    puts "Поезд #{@serial} остановлен"
  end

  def increase_speed(num = 10)
    @speed += num
    puts "Скорость увеличена на #{num}, текущая скорость #{@speed} "
  end

  def add_carriage
    self.stop
    puts "Поезд остановлен для добавления вагона в состав"
    @carriages += 1
  end

  def remove_carriage
    self.stop
    puts "Поезд остановлен для удаления вагона из состава"
    @carriages -= 1
  end

  def add_route(route)
    @route = route
    @station = @route.route[0]
    @station.add_train(self)
    puts "У поезда задан маршрут, поезд перемещён в к начальной станции #{@station.name}"
  end

  def move_forward
    i = @route.route.index(@station)
    if i == (@route.route.size - 1)
      puts "Поезд уже на конечной станции"
    else
      @station = @route.route[i + 1]
      @station.add_train(self)
      puts "Поезд перемещён к следующей станции #{@station.name}"
    end
  end

  def move_back
    i = @route.route.index(@station)
    if i == 0
      puts "Поезд на первой станции"
    else
      @station = @route.route[i - 1]
      @station.add_train(self)
      puts "Поезд перемещён к предыдущей станции #{@station.name}"
    end
  end

  def previous_station
    if @route
      i = @route.route.index(@station)
      if i > 0
        puts "Предыдущая станция #{@serial} #{@route.route[i - 1].name}"
      else
        puts "Поезд находится на самой первой станции"
      end
    else
      puts "У поезда не задан маршрут"
    end
  end

  def next_station
    if @route
      i = @route.route.index(@station)
      if i < (@route.route.size - 1)
        puts "Следующая станция поезда #{@serial} #{@route.route[i + 1].name}"
      else
        puts "Поезд находится на последней станции"
      end
    else
      puts "У поезда не задан маршрут"
    end
  end

end
