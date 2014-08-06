class ChecksForTickets

  attr_accessor :event

  def initialize(event)
    @event = event
  end

  def available_tickets
    event.tickets.unsold.count
  end

  def available?
    available_tickets > 0
  end

  def reason
    :sold_out
  end
end
