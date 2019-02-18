require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :carriages, :speed, :serial, :route, :type
  attr_accessor :station

  SERIAL_FORMAT = /^[\w\d]{3}-?[\w\d]{2}$/.freeze

  @@trains = {}

  def self.find(serial)
    @@trains[serial]
  end

  def initialize(serial)
    @serial = serial.to_s
    @carriages = []
    @speed = 0
    validate!
    @@trains[@serial] = self
    register_instance
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def moving?
    @speed.zero?
  end

  def stop
    @speed = 0 if moving?
  end

  def increase_speed(num = 10)
    @speed += num
  end

  def add_carriage(carriage)
    stop
    if carriage.type == @type
      carriages << carriage
      carriage.on_board = true
    else
      false
    end
  end

  def remove_carriage(carriage)
    stop
    if @carriages.include?(carriage)
      @carriages.delete(carriage)
      return carriage.on_board = false
    end
    false
  end

  def add_route(route)
    @route = route
    @station = @route.stations[0]
    @station.add_train(self)
  end

  def move_forward
    i = @route.stations.index(@station)
    if i == (@route.stations.size - 1)
      false
    else
      @station = @route.stations[i + 1]
      @station.add_train(self)
    end
  end

  def move_back
    i = @route.stations.index(@station)
    if i.zero?
      false
    else
      @station = @route.stations[i - 1]
      @station.add_train(self)
    end
  end

  def each_carriage(&block)
    if block.arity == 2
      @carriages.each_with_index { |carriage, index| yield index, carriage }
    else
      @carriages.each { |carriage| yield carriage }
    end
  end

  def previous_station
    return false unless @route

    i = @route.stations.index(@station)
    return false if i.zero?

    @route.stations[i - 1]
  end

  def next_station
    return false unless @route

    i = @route.stations.index(@station)
    last_station = @route.stations.size - 1
    return false if i == last_station

    @route.stations[i + 1]
  end

  protected

  attr_writer :carriages, :speed, :serial, :route, :type

  def validate!
    raise 'Номер поезда должен быть строкой' unless @serial.is_a? String
    raise 'Номер поезда не может быть не задан' if @serial.empty?
    raise 'Формат номера: ***-**' if @serial !~ SERIAL_FORMAT
  end
end
