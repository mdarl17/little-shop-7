class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def invoice
    self.invoices.each do |invoice|
      invoice.id
      
      # require 'pry'; binding.pry
    end

  end
end