class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  belongs_to :customer
  
  enum status: {"cancelled": 0, "in progress": 1, "completed": 2}

  def self.incomplete
    where(status: 1).order(:created_at)
  end

  def date
    created_at.strftime "%A, %B %-d, %Y"
  end
end