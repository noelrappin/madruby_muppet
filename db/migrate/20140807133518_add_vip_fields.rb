class AddVipFields < ActiveRecord::Migration
  def change
    add_column :users, :access_level, :string
    add_column :events, :vip_capacity, :integer
    add_column :tickets, :access_level, :string
  end
end
