require "rails_helper"

RSpec.describe CreatesEvent do

  it "builds an event with tickets" do
    creator = CreatesEvent.new(name: "Event", description: "Event",
      performance_time: Time.current, capacity: 2)
    creator.create
    expect(creator.event.general_ticket_bank).to have(2).unsold_tickets
  end

  it "builds an event with VIP tickets" do
    creator = CreatesEvent.new(name: "Event", description: "Event",
      performance_time: Time.current, capacity: 2, vip_capacity: 2)
    creator.create
    expect(creator.event.general_ticket_bank).to have(2).unsold_tickets
    expect(creator.event.vip_ticket_bank).to have(4).unsold_tickets
  end

end
