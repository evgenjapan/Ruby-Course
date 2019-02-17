class PassengerTrain < Train
  def initialize(serial)
    super(serial)
    @type = :passenger
  end
end
