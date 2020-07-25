class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :subject
      t.string :body

      t.timestamps
    end
  end
end
