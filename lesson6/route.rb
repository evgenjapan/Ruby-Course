class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(start_point, finish_point)
    @start_point = start_point
    @finish_point = finish_point
    @stations = [start_point, finish_point]
    validate
    register_instance
  end

  def valid?
    validate
    true
  rescue
    false
  end

  def add_intermediate(station)
    @stations.insert(-2, station)
  end

  def delete_intermediate(station)
    @stations.delete(station) if @stations.include?(station)
  end

  def show_route
    @stations.each {|station| puts station.name}
    end

  protected
  def validate
    raise "Первая и конечная станция не могут быть одинаковы" if @start_point == @finish_point
    raise "Вы поезду некуда ехать, уважайте поезд, добавьте станцию" if @stations.size < 2
    raise "Не все объекты в маршруте являются станциями" unless @stations.all? {|station| station.is_a?(Station)}
  end
end
