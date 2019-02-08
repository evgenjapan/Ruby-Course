require_relative 'manufacturer'
require_relative 'instance_counter'
class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :carriages, :speed, :serial, :route, :type
  attr_accessor :station

  @@trains = {}

  def self.find(serial)
    @@trains[serial]
  end

  def initialize(serial)
    @serial = serial
    @carriages = []
    @speed = 0
    @@trains[@serial] = self
    register_instance
    puts "Сегодня был построен и выпущен поезд #{serial}"

  end

  def moving?
    @speed == 0
  end

  def stop
    if self.moving?
      puts "Поезд #{@serial} остановлен"
      @speed = 0
    end
  end

  def increase_speed(num = 10)
    puts "Скорость увеличена на #{num}, текущая скорость #{@speed + 10} "
    @speed += num
  end

  def add_carriage(carriage)
    self.stop
    puts "Поезд остановлен для добавления вагона в состав"
    if carriage.type == @type
      self.carriages << carriage
      carriage.on_board = true
    else
      puts "Этот вагон нельзя добавить в состав"
    end
  end

  def remove_carriage(carriage)
    self.stop
    puts "Поезд остановлен для удаления вагона из состава"
    if @carriages.include?(carriage)
      @carriages.delete(carriage)
      return carriage.on_board = false
    end
    puts "Такого вагона нет в составе"
  end

  def add_route(route)
    @route = route
    @station = @route.stations[0]
    @station.add_train(self)
  end

  def move_forward
    i = @route.stations.index(@station)
    if i == (@route.stations.size - 1)
      puts "Поезд уже на конечной станции"
    else
      puts "Поезд перемещён к следующей станции #{@station.name}"
      @station = @route.stations[i + 1]
      @station.add_train(self)
    end
  end

  def move_back
    i = @route.stations.index(@station)
    if i == 0
      puts "Поезд на первой станции"
    else
      puts "Поезд перемещён к предыдущей станции #{@station.name}"
      @station = @route.stations[i - 1]
      @station.add_train(self)
    end
  end

  def previous_station
    return puts "У поезда не задан маршрут" unless @route
    i = @route.stations.index(@station)
    return puts "Поезд находится на самой первой станции" if i == 0
    previous = @route.stations[i - 1]
    puts "Предыдущая станция на пути #{@serial} #{previous.name}"
    previous
  end

  def next_station
    return puts "У поезда не задан маршрут" unless @route
    i = @route.stations.index(@station)
    last_station = @route.stations.size - 1
    return puts "Поезд находится на последней станции" if i == last_station
    next_station = @route.stations[i+1]
    puts "Следующая станция на пути #{@serial} #{next_station.name}"
    next_station
  end

  private
  attr_writer :carriages, :speed, :serial, :route, :type
end
