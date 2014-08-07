class ChecksForTickets

  attr_accessor :event, :user

  def initialize(event, user = nil)
    @event = event
    @user = user
  end

  def available_tickets
    event.unsold_ticket_count + (user.try(:vip?) ? event.unsold_vip_ticket_count : 0)
  end

  def available?
    reason == :on_sale
  end

  def all_tickets_sold?
    general = event.sold_ticket_count >= event.capacity
    return general unless general && user && user.vip?
    event.sold_vip_ticket_count >= event.vip_capacity
  end

  def all_tickets_accounted_for?
    general = event.sold_ticket_count + event.cart_ticket_count >= event.capacity
    return general unless general && user && user.vip?
    event.sold_vip_ticket_count + event.cart_vip_ticket_count >= event.vip_capacity
  end

  def reason
    return :past_event if event.past?
    return :sold_out if all_tickets_sold?
    return :on_hold if all_tickets_accounted_for?
    return :on_sale
  end
end
