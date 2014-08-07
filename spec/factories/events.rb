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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name "Muppet Show"
    description "This is what we call it"
    performance_time { 1.month.from_now }
    capacity 1
  end
end
