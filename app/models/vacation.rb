class Vacation < ApplicationRecord

  
  def days
    (end_date - start_date).to_i + 1
  end


end
