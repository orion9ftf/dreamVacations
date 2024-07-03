class AddIdEmployeeToVacations < ActiveRecord::Migration[6.1]
  def change
    add_column :vacations, :id_employee, :integer
  end
end
