gstrequire "rails_helper"

RSpec.describe "checking for availablity" do

  let(:creator) { CreatesEvent.new(name: "Today's Event", capacity: 2,
        performance_time: 1.month.from_now) }
  let(:event) { creator.create; creator.event }

  scenario "tickets are available" do
    visit event_path(event)
    expect(page).to have_selector("#available", text: "2")
    expect(page).not_to have_selector("#unavailable")
  end
end
