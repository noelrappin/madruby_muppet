require "rails_helper"

RSpec.describe ChecksForTickets do
  let(:event) { Event.new(name: "Today's Event",
      capacity: 2, performance_time: 1.month.from_now) }
  let(:checker) { ChecksForTickets.new(event) }

  def stub_ticket_counts(event, sold: 0, cart: 0)
    remaining = event.capacity - sold - cart
    allow(event).to receive(:sold_ticket_count).and_return(sold)
    allow(event).to receive(:cart_ticket_count).and_return(cart)
    allow(event).to receive(:unsold_ticket_count).and_return(remaining)
  end

  describe "basic availability" do

    it "assumes unsold tickets are available" do
      stub_ticket_counts(event, sold: 0, cart: 0)
      expect(checker.available_tickets).to eq(2)
      expect(checker).to be_available
    end

    it "assumes sold tickets are unavailable" do
      stub_ticket_counts(event, sold: 2, cart: 0)
      expect(checker).not_to be_available
      expect(checker.reason).to eq :sold_out
    end

    it "does not show old events as available" do
      stub_ticket_counts(event, sold: 0, cart: 0)
      event.performance_time = 1.month.ago
      expect(checker).not_to be_available
      expect(checker.reason).to eq(:past_event)
    end

    it "doesn't count cart tickets as available" do
      stub_ticket_counts(event, sold: 1, cart: 1)
      expect(checker).not_to be_available
      expect(checker.reason).to eq :on_hold
    end

  end
end
