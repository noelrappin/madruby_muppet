class ChecksForTickets

  attr_accessor :event, :user

  def initialize(event, user = nil)
    @event = event
    @user = user
  end

  def access_level
    @user.try(:access_level) || "general"
  end

  def ticket_bank
    @ticket_bank ||= event.ticket_bank_for(access_level)
  end

  def available_tickets
    ticket_bank.unsold_ticket_count
  end

  def available?
    reason == :on_sale
  end

  def all_tickets_sold?
    ticket_bank.sold_ticket_count >= ticket_bank.capacity
  end

  def all_tickets_accounted_for?
    general = ticket_bank.sold_ticket_count + ticket_bank.cart_ticket_count >= ticket_bank.capacity
  end

  def reason
    return :past_event if event.past?
    return :sold_out if all_tickets_sold?
    return :on_hold if all_tickets_accounted_for?
    return :on_sale
  end
end
