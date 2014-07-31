# == Schema Information
#
# Table name: tickets
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Ticket, :type => :model do

  describe "scopes" do
    let!(:unsold) { FactoryGirl.create(:ticket, status: "unsold") }
    let!(:sold) { FactoryGirl.create(:ticket, status: "sold") }

    it "can find unsold and sold tickets" do
      expect(Ticket.unsold).to eq([unsold])
      expect(Ticket.sold).to eq([sold])
    end

    it "can make a ticket change status" do
      unsold.sold!
      expect(unsold).to be_sold
    end

    it "can unsell a ticket" do
      sold.unsold!
      expect(sold).to be_unsold
    end

  end

end
