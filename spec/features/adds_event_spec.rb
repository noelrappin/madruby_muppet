require "rails_helper"

RSpec.describe "adding an event" do

  it "creates new ticket objects" do
    visit new_event_path
    fill_in "Name", with: "A New Event"
    fill_in "Capacity", with: 2
    click_on "Create Event"
    visit events_path
    expect(page).to have_selector(".name", text: "A New Event")
    expect(page).to have_selector(".capacity", text: "2")
    expect(page).to have_selector(".unsold_ticket_count", text: "2")
  end

end
