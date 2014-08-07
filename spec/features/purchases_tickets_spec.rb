require "rails_helper"

RSpec.describe "checking for availablity" do
  include Warden::Test::Helpers
  Warden.test_mode!

  describe "for ordinary users" do

    let(:creator) { CreatesEvent.new(name: "Today's Event", capacity: 2,
          performance_time: 1.month.from_now) }
    let(:event) { creator.create; creator.event }

    scenario "tickets are available" do
      visit event_path(event)
      expect(page).to have_selector("#available", text: "2")
      expect(page).not_to have_selector("#unavailable")
    end
  end

  describe "for VIP users" do
    let(:creator) { CreatesEvent.new(name: "Today's Event",
        capacity: 2, vip_capacity: 2,
        performance_time: 1.month.from_now) }
    let(:event) { creator.create; creator.event }
    let(:vip) { FactoryGirl.create(:user, access_level: "vip") }

    scenario "for a non logged in user, tickets are unavailable" do
      event.tickets.general.each { |t| t.sold! }
      visit event_path(event)
      expect(page).not_to have_selector("#available")
      expect(page).to have_selector("#unavailable")
    end

    scenario "a vip user should be able to find vip tickets" do
      event.tickets.general.each { |t| t.sold! }
      login_as(vip, scope: :user)
      visit event_path(event)
      expect(page).to have_selector("#available", text: "2")
      expect(page).not_to have_selector("#unavailable")
    end
  end
end
