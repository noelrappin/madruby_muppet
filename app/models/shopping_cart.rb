class ShoppingCart

  attr_accessor :ticket_count, :event_id, :user_id

  include ActiveModel::Model

  def event
    @event ||= Event.find(event_id)
  end

  def user
    @user ||= User.find(user_id)
  end

  def ticket_bank
    event.ticket_bank_for(user.access_level)
  end

  def add!
    ticket_bank.unsold_tickets.take(ticket_count.to_i).each { |t| t.cart!(user_id)}
  end

end
