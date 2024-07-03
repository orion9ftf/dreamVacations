class Vacation < ApplicationRecord
  validates :employee_name, :leader, :start_date, :type, :reason, :state, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: 
  /\A[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}\z/i, message: ": Por favor introduzca un email válido"}

  def days
    (end_date - start_date).to_i + 1
  end
end
