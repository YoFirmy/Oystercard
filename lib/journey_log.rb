require_relative 'journey'

class JourneyLog

  attr_reader :current_journey

  def initialize(journey_class: Journey )
    @journey_class = journey_class
  end

  def start(station)  
    @current_journey = @journey_class.new(station)
  end

  # def finish(station)
    
  # end

  private
  attr_reader :journey_class

  def current_journey 
    @current_journey ||= journey_class.new
  end


end
