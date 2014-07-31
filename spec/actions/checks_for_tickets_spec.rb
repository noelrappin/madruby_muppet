require "rails_helper"

RSpec.describe ChecksForTickets do
  let(:event) { FactoryGirl.build_stubbed(:event, capacity: 10) }
  let(:checker) { ChecksForTickets.new(event) }

  describe "basic availability" do

    before do
      allow(event).to receive(:unsold_ticket_count).and_return(10)
    end

    it "assumes unsold tickets are available" do
      expect(checker.available_tickets).to eq(10)
      expect(checker).to be_available
    end

    it "knows when an event is sold out" do
      allow(event).to receive(:unsold_ticket_count).and_return(0)
      allow(event).to receive(:cart_ticket_count).and_return(0)
      allow(event).to receive(:sold_ticket_count).and_return(10)
      expect(checker).not_to be_available
      expect(checker.reason).to eq :sold_out
    end

    it "knows that tickets in the past are unavailable" do
      event.performance_time = 1.month.ago
      expect(checker).not_to be_available
      expect(checker.reason).to eq :past_event
    end

    it "doesn't count cart tickets as available" do
      allow(event).to receive(:unsold_ticket_count).and_return(0)
      allow(event).to receive(:cart_ticket_count).and_return(2)
      allow(event).to receive(:sold_ticket_count).and_return(8)
      expect(checker).not_to be_available
      expect(checker.reason).to eq :on_hold
    end
  end

end
