class ChecksForTickets

  attr_accessor :event

  def initialize(event)
    @event = event
  end

  def available_tickets
    return 0 if reason
    event.unsold_ticket_count
  end

  def available?
    reason.nil?
  end

  def reason
    return :past_event if event.past?
    return :sold_out if event.sold_out?
    return :on_hold if event.on_hold?
    nil
  end
end
