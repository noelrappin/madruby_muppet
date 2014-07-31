require "rails_helper"

feature "checking for availablity" do

  background do
    creator = CreatesEvent.new(name: "Today's Event", capacity: 2,
        performance_time: 1.month.from_now)
    creator.create
    @event = creator.event
  end

  scenario "tickets are available" do
    visit event_path(@event)
    expect(page).to have_selector("#available", text: "2")
    expect(page).not_to have_selector("#unavailable")
  end

  scenario "tickets are not available" do
    @event.tickets.each { |t| t.sold! }
    visit event_path(@event)
    expect(page).to have_selector("#unavailable")
    expect(page).not_to have_selector("#available", text: "2")
  end

end
