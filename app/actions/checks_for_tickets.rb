class ChecksForTickets

  attr_accessor :event

  def initialize(event)
    @event = event
  end

  def available_tickets
    event.tickets.unsold.count
  end

  def available?
    reason == :on_sale
  end

  def reason
    return :past_event if event.past?
    return :sold_out if available_tickets <= 0
    return :on_sale
  end
end
