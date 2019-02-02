class CargoTrain < Train
  def initialize(serial)
    super(serial)
    @type = :cargo
  end
end