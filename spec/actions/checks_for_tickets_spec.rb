require "rails_helper"

RSpec.describe ChecksForTickets do
  let(:creator) { CreatesEvent.new(name: "Today's Event",
      capacity: 2, performance_time: 1.month.from_now) }
  let(:event) { creator.create; creator.event }
  let(:checker) { ChecksForTickets.new(event) }

  describe "basic availability" do

    it "assumes unsold tickets are available" do
      expect(checker.available_tickets).to eq(2)
      expect(checker).to be_available
    end

    it "assumes sold tickets are unavailable" do
      event.tickets.each { |t| t.sold! }
      expect(checker).not_to be_available
      expect(checker.reason).to eq :sold_out
    end

    it "does not show old events as available" do
      event.performance_time = 1.month.ago
      expect(checker).not_to be_available
      expect(checker.reason).to eq(:past_event)
    end

    it "doesn't count cart tickets as available" do
      event.tickets.unsold.take(1).each { |t| t.sold! }
      event.tickets.unsold.take(1).each { |t| t.cart! }
      expect(checker).not_to be_available
      expect(checker.reason).to eq :on_hold
    end

  end
end
