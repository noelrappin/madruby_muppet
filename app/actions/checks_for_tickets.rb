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

  def all_tickets_sold?
    event.tickets.sold.count >= event.capacity
  end

  def all_tickets_accounted_for?
    event.tickets.sold.count + event.tickets.cart.count >= event.capacity
  end

  def reason
    return :past_event if event.past?
    return :sold_out if all_tickets_sold?
    return :on_hold if all_tickets_accounted_for?
    return :on_sale
  end
end
