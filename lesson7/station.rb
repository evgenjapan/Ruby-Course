class Station
  include InstanceCounter

  attr_reader :name, :trains

  @@stations = []

  def self.all
    @@stations
  end

  instances

  def initialize(name)
    @name = name.to_s
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def add_train(train)
    @trains << train
    train.station = self
  end

  def show_trains
    @trains.each {|train| puts train.serial }
  end

  def each_train(&block)
    if block.arity == 2
      @trains.each_with_index {|index, train| yield index, train}
    else
      @trains.each {|train| yield train}
    end
  end

  def get_trains_by_type
    cargo = 0
    passenger = 0
    @trains.each {|train| train.type == :cargo ? cargo += 1 : passenger += 1 }
    {cargos: cargo, passengers: passenger}
  end

  def move_train(train)
    @trains.delete(train)
    train.move_forward  if train.route
  end
  private
  attr_writer :name, :trains
  def validate!
    raise 'Название станции должно быть больше 2 символов' if @name.size < 3
  end
end
