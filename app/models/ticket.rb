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

class Ticket < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  STATUS = %w(unsold sold)

  STATUS.each do |status_string|
    define_singleton_method(status_string) do
      where(status: status_string)
    end

    define_method(:"#{status_string}?") do
      status == status_string
    end

    define_method(:"#{status_string}!") do
      update_attributes(status: status_string)
    end
  end

end
