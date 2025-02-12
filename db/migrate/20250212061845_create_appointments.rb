class CreateAppointments < ActiveRecord::Migration[7.2]
  def change
    create_table :appointments do |t|
      t.string :firstname
      t.string :lastname
      t.string :department
      t.text :reasons
      t.datetime :appointment_date

      t.timestamps
    end
  end
end
