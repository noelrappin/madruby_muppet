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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ticket do
    event nil
    status "MyString"
  end
end
