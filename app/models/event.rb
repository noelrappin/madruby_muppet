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

  def unsold_tickets
    tickets.unsold
  end

end
