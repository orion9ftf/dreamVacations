class CreateVacations < ActiveRecord::Migration[6.1]
  def change
    create_table :vacations do |t|
      t.string :employee_name
      t.string :email
      t.string :leader
      t.date :start_date
      t.date :end_date
      t.string :type
      t.text :reason
      t.string :state

      t.timestamps
    end
  end
end
