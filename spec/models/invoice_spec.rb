require "rails_helper"

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should belong_to(:customer) }
  end

  describe "methods" do
    before :each do
      @merchant1 = Merchant.create!(name: "Hannah's Handbags")

      @customer1 = Customer.create!(first_name: "Joey", last_name: "Ondricka")
      @customer2 = Customer.create!(first_name: "Cecelia", last_name: "Osinski")
      @customer3 = Customer.create!(first_name: "Mariah", last_name: "Toy")
      @customer4 = Customer.create!(first_name: "Leanne", last_name: "Braun")
      @customer5 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
      @customer6 = Customer.create!(first_name: "Heber", last_name: "Kuhn")
      @customer7 = Customer.create!(first_name: "Parker", last_name: "Daugherty")

      @invoice1 = Invoice.create!(status: "completed", customer_id: @customer1.id, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2012-03-25 09:54:09 UTC")
      @invoice2 = Invoice.create!(status: "completed", customer_id: @customer2.id, created_at: "2012-03-12 05:54:09 UTC", updated_at: "2012-03-12 05:54:09 UTC")
      @invoice3 = Invoice.create!(status: "completed", customer_id: @customer3.id, created_at: "2012-03-10 00:54:09 UTC", updated_at: "2012-03-10 00:54:09 UTC")
      @invoice4 = Invoice.create!(status: "completed", customer_id: @customer4.id, created_at: "2012-03-24 15:54:10 UTC", updated_at: "2012-03-24 15:54:10 UTC")
      @invoice5 = Invoice.create!(status: "completed", customer_id: @customer5.id, created_at: "2012-03-07 19:54:10 UTC", updated_at: "2012-03-07 19:54:10 UTC")
      @invoice6 = Invoice.create!(status: "completed", customer_id: @customer6.id, created_at: "2012-03-09 01:54:10 UTC", updated_at: "2012-03-09 01:54:10 UTC")
      @invoice7 = Invoice.create!(status: "completed", customer_id: @customer7.id, created_at: "2012-03-07 21:54:10 UTC", updated_at: "2012-03-07 21:54:10 UTC")
      @invoice8 = Invoice.create!(status: "in progress", customer_id: @customer7.id, created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-13 16:54:10 UTC")
      @invoice9 = Invoice.create!(status: "in progress", customer_id: @customer7.id, created_at: "2012-03-07 12:54:10 UTC", updated_at: "2012-03-07 12:54:10 UTC")
      @invoice10 = Invoice.create!(status: "cancelled", customer_id: @customer7.id, created_at: "2012-03-06 21:54:10 UTC", updated_at: "2012-03-06 21:54:10 UTC")
      @invoice11 = Invoice.create!(status: "in progress", customer_id: @customer7.id, created_at: "2012-03-08 20:54:10 UTC", updated_at: "2012-03-07 12:54:10 UTC")

      @item1 = Item.create!(name: "Item Qui Esse", description: "Nihil autem sit odio inventore deleniti.", unit_price: 75107, merchant_id: @merchant1.id)
      @item2 = Item.create!(name: "Item Autem Minima", description: "Cumque consequuntur ad.", unit_price: 67076, merchant_id: @merchant1.id)
      @item3 = Item.create!(name: "Platinum Necklace", description: "100k platiunum.", unit_price: 1000, merchant_id: @merchant1.id)
      @item4 = Item.create!(name: "Gold Watch", description: "24k Gold", unit_price: 10000, merchant_id: @merchant1.id)
      @item5 = Item.create!(name: "Diamond Ring", description: "Flawless cut, color, and clarity", unit_price: 10000, merchant_id: @merchant1.id)

      @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 9, unit_price: 1000)
      @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 14, unit_price: 5000)
      @invoice_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 19, unit_price: 10000)
      @invoice_item4 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice1.id, quantity: 25, unit_price: 50000)

      @discount1 = Discount.create!(discount: 20, qty: 10, merchant_id: @merchant1.id)
      @discount2 = Discount.create!(discount: 30, qty: 15, merchant_id: @merchant1.id)
      @discount3 = Discount.create!(discount: 35, qty: 20, merchant_id: @merchant1.id)

    end

    describe "#self.incomplete_by_creation_date" do
      it "gives all invoices with a status of in progress" do
        expect(Invoice.incomplete_by_creation_date).to eq([@invoice9, @invoice11, @invoice8])
      end
    end

    describe "#creation_date" do
      it "gives the date of creation in a specific format" do 
        expect(@invoice11.creation_date).to eq("Thursday, March 8, 2012")
      end
    end

    describe "#customer_name" do
      it "can give the full name of a customer associated with a given invoice" do
        expect(@invoice11.customer_name).to eq("Parker Daugherty")
      end
    end

    describe '#revenue' do
      it 'tells the total revenue of an invoice' do
        expect(@invoice1.revenue).to eq(1519000)
      end
    end

    describe "#alphabetical" do
      it "returns invoices in order by id" do
        expect(Invoice.alphabetical).to eq([@invoice1, @invoice2, @invoice3, @invoice4, @invoice5, @invoice6, @invoice7, @invoice8, @invoice9, @invoice10, @invoice11])
      end
    end

    describe "#most_recent" do
      it "returns invoices in order of most recently created" do
        customer1 = Customer.create!(first_name: "Joey", last_name: "Ondricka")
        invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2012-03-25 09:54:09 UTC")
        invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2012-03-10 05:54:09 UTC", updated_at: "2012-03-12 05:54:09 UTC")
        invoice3 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2012-03-12 00:54:09 UTC", updated_at: "2012-03-10 00:54:09 UTC")
        
        expect(customer1.invoices.most_recent).to eq([invoice1, invoice3, invoice2])
      end
    end

    describe "#sort_invoice_items" do
      it "sorts invoice items by most recent if sort param is 'date'" do
        customer1 = Customer.create!(first_name: "Joey", last_name: "Ondricka")
        invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2012-03-25 09:54:09 UTC")
        invoice_item1 = invoice1.invoice_items.create!(item_id: @item1.id, quantity: 2, unit_price: 10, created_at: "2012-03-15 09:54:09 UTC", updated_at: "2012-03-25 09:54:09 UTC")
        invoice_item2 = invoice1.invoice_items.create!(item_id: @item2.id, quantity: 2, unit_price: 4, created_at: "2012-03-23 09:54:09 UTC", updated_at: "2012-03-25 09:54:09 UTC")
        invoice_item3 = invoice1.invoice_items.create!(item_id: @item1.id, quantity: 2, unit_price: 10, created_at: "2012-03-29 09:54:09 UTC", updated_at: "2012-03-25 09:54:09 UTC")

        expect(invoice1.sort_invoice_items(sort: "date").to_a).to eq([invoice_item3, invoice_item2, invoice_item1])
        expect(invoice1.sort_invoice_items(sort: "not_date").to_a).to eq([invoice_item1, invoice_item2, invoice_item3])
      end
    end
    
    describe "#change_status" do
      it "toggles the status" do
        expect(@invoice1.status).to eq("completed")
        @invoice1.change_status("cancelled")
        expect(@invoice1.status).to eq("cancelled")
        @invoice1.change_status("in progress")
        expect(@invoice1.status).to eq("in progress")
      end
    end

    describe "#total_revenue" do 
      it "calculates the total revenue without bulk discounts" do 
        expect(@invoice1.total_revenue).to eq(1519000)
      end
      
      describe "#total_revenue_less_discount"
      it "calculates the total revenue with bulk discounts applied" do 
        expect(@invoice1.total_revenue_less_discounts).to eq(1010500)
      end
    end
  end
end


