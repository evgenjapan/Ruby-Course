class Carriage
  include Manufacturer

  attr_reader :type
  attr_accessor :on_board

  def initialize(extra)
    @on_board = false
  end
end
