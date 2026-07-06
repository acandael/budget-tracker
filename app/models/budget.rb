class Budget < ApplicationRecord
  has_many :transactions, dependent: :destroy
  
  def formatted_month
    month.strftime("%B %Y")
  end

end
