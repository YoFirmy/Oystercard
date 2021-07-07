class Station
  DEFAULT_ZONE = 'z'
  attr_accessor :zone
  attr_reader :name

  def initialize(name)
    @name = name
    @zone = DEFAULT_ZONE
  end
end