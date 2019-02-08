class Station
  include InstanceCounter

  attr_reader :name, :trains
  
  @@stations = {}

  def self.all
    @@stations
  end

  instances

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
    puts "Сегодня была открыта станция #{name}"
  end

  def add_train(train)
    puts "Поезд с серийным номером #{train.serial} прибыл на станцию #{@name}"
    @trains << train
    train.station = self
  end

  def show_trains
    puts "Поезда на станции #{@name}:"
    @trains.each {|train| puts "Поезд с серийным номером #{train.serial}" }
  end

  def get_trains_by_type
    cargo = 0
    passenger = 0
    @trains.each {|train| train.type == :cargo ? cargo += 1 : passenger += 1 }
    puts "Пассажирских #{passenger} Грузовых #{cargo} - поездов на станции #{@name}"
    {cargos: cargo, passengers: passenger}
  end

  def move_train(train)
    puts "Поезд с серийным номером #{train.serial} покидает станцию #{@name}"
    @trains.delete(train)
    train.move_forward  if train.route
  end
  private
  attr_writer :name, :trains
end
