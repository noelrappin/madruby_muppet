require "rails_helper"

RSpec.describe CreatesEvent do

  it "builds an event with tickets" do
    creator = CreatesEvent.new(name: "Event", description: "Event",
      performance_time: Time.current, capacity: 2)
    creator.create
    expect(creator.event).to have(2).unsold_tickets
  end

end
