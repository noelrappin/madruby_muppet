require "rails_helper"

RSpec.describe ShoppingCart do

  describe "add to cart" do
    let(:event) { FactoryGirl.build_stubbed(:event) }
    let(:user) { FactoryGirl.build_stubbed(:user, access_level: "general") }
    let(:bank) { TicketBank.new(event,
        [Ticket.new(status: "unsold"), Ticket.new(status: "unsold"),
            Ticket.new(status: "unsold")]) }

    it "marks tickets in cart" do
      cart = ShoppingCart.new(
          ticket_count: 2, event_id: event.id, user_id: user.id)
      allow(cart).to receive(:event).and_return(event)
      allow(cart).to receive(:user).and_return(user)
      allow(event).to receive(:general_ticket_bank).and_return(bank)
      cart.add!
      expect(event.general_ticket_bank.tickets.map(&:status))
          .to eq(["cart", "cart", "unsold"])
      expect(event.general_ticket_bank.tickets.map(&:user_id))
          .to eq([user.id, user.id, nil])
    end
  end

end
