class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :event, index: true
      t.references :user, index: true
      t.string :status

      t.timestamps
    end
  end
end
