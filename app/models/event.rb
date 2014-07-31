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

class Event < ActiveRecord::Base
  has_many :tickets
  has_many :users, through: :tickets

  validates :capacity, numericality: {greater_than: 0}
  delegate :past?, to: :performance_time

  Ticket::STATUS.each do |status|
    define_method :"#{status}_tickets" do
      tickets.send(status.to_sym)
    end

    define_method :"#{status}_ticket_count" do
      tickets.send(status.to_sym).count
    end
  end

  def sold_out?
    sold_ticket_count >= capacity
  end

  def on_hold?
    sold_ticket_count + cart_ticket_count >= capacity
  end

end
