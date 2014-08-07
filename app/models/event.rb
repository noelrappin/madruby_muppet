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

class Event < ActiveRecord::Base
  has_many :tickets
  has_many :users, through: :tickets

  validates :capacity, numericality: {greater_than: 0}

  delegate :past?, to: :performance_time

  def general_ticket_bank
    TicketBank.new(self, tickets.general)
  end

  def vip_ticket_bank
    TicketBank.new(self, tickets.general + tickets.vip)
  end

  def ticket_bank_for(access_type)
    send(:"#{access_type}_ticket_bank")
  end

end
