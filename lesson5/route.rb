class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(start_point, finish_point)
    @stations = [start_point, finish_point]
    register_instance
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

  private

  attr_writer :stations
end
