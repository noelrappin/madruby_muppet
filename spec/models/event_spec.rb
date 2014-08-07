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
#  vip_capacity     :integer
#

require 'rails_helper'

RSpec.describe Event, :type => :model do

  describe "ticket bank" do

    let(:event) { Event.create(name: "Today's Event", capacity: 1,
        vip_capacity: 1, performance_time: 1.month.from_now) }
    let(:ticket) { Ticket.new(access_level: "general") }
    let(:vip_ticket) { Ticket.new(access_level: "vip") }

    before do
      event.tickets = [ticket, vip_ticket]
    end

    specify { expect(event.general_ticket_bank.tickets)
        .to match_array([ticket]) }
    specify { expect(event.vip_ticket_bank.tickets)
        .to match_array([ticket, vip_ticket]) }
    specify { expect(event.ticket_bank_for("general")
        .tickets).to match_array([ticket]) }
    specify { expect(event.ticket_bank_for("vip").tickets)
        .to match_array([ticket, vip_ticket]) }
  end

end
