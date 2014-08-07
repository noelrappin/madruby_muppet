# == Schema Information
#
# Table name: tickets
#
#  id           :integer          not null, primary key
#  event_id     :integer
#  status       :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  access_level :string(255)
#

class Ticket < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  STATUS = %w(unsold sold cart)


  STATUS.each do |status_string|
    define_singleton_method(status_string) do
      where(status: status_string)
    end

    define_method(:"#{status_string}?") do
      status == status_string
    end

    define_method(:"#{status_string}!") do |user_id = nil|
      update_attributes(status: status_string, user_id: user_id)
    end
  end

  ACCESS_TYPE = %w(general vip)
  ACCESS_TYPE.each do |access_string|
    define_singleton_method(access_string) do
      where(access_level: access_string)
    end

    define_method(:"#{access_string}?") do
      access_level == status_string
    end
  end

end
