# == Schema Information
#
# Table name: events
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  description      :text
#  performance_time :datetime
#  capacity         :integer
#  created_at       :datetime
#  updated_at       :datetime
#

require 'rails_helper'

RSpec.describe Event, :type => :model do

  describe "ticket status" do

    let(:event) { FactoryGirl.build_stubbed(:event, capacity: 10) }

    it "knows an event is is not full" do
      allow(event).to receive(:unsold_ticket_count).and_return(5)
      allow(event).to receive(:sold_ticket_count).and_return(5)
      expect(event).not_to be_sold_out
    end

    it "knows an event is full" do
      allow(event).to receive(:unsold_ticket_count).and_return(0)
      allow(event).to receive(:sold_ticket_count).and_return(10)
      expect(event).to be_sold_out
    end

    it "knows an event is on hold" do
      allow(event).to receive(:unsold_ticket_count).and_return(0)
      allow(event).to receive(:sold_ticket_count).and_return(8)
      allow(event).to receive(:cart_ticket_count).and_return(2)
      expect(event).not_to be_sold_out
      expect(event).to be_on_hold
    end


  end

end
