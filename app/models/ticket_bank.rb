class TicketBank

  attr_accessor :event, :tickets, :capacity

  def initialize(event, tickets)
    @tickets = tickets
    @capacity = tickets.size
  end

  Ticket::STATUS.each do |status_string|
    define_method :"#{status_string}_tickets" do
      tickets.select { |t| t.status == status_string }
    end

    define_method :"#{status_string}_ticket_count" do
      send(:"#{status_string}_tickets").count
    end
  end
end
