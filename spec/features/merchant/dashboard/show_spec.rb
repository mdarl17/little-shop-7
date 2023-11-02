require "rails_helper"

RSpec.describe "Merchant Dashboard", type: :feature do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Hannah's Handbags")
    @merchant2 = Merchant.create!(name: "Jason's Furniture")
    
    @customer_1 = Customer.create!(first_name: "John", last_name: "Jacobs")
    @customer_2 = Customer.create!(first_name: "Susan", last_name: "Robinson")
    @customer_3 = Customer.create!(first_name: "Jessica", last_name: "Simpson")
    @customer_4 = Customer.create!(first_name: "Harry", last_name: "Potter")
    @customer_5 = Customer.create!(first_name: "Ron", last_name: "Weasley")
    @customer_6 = Customer.create!(first_name: "Nicole", last_name: "Johnson")
    @customer_7 = Customer.create!(first_name: "Jackie", last_name: "Chan")
    
    @invoice_1 = Invoice.create!(status: 0, customer_id: @customer_1.id)
    @invoice_2 = Invoice.create!(status: 2, customer_id: @customer_2.id)
    @invoice_3 = Invoice.create!(status: 2, customer_id: @customer_3.id)
    @invoice_4 = Invoice.create!(status: 2, customer_id: @customer_4.id)
    @invoice_5 = Invoice.create!(status: 2, customer_id: @customer_5.id)
    @invoice_6 = Invoice.create!(status: 2, customer_id: @customer_6.id)
    @invoice_7 = Invoice.create!(status: 0, customer_id: @customer_7.id)
    @invoice_8 = Invoice.create!(status: 0, customer_id: @customer_7.id)
    
    @transaction_1 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 1, invoice_id: @invoice_1.id)
    @transaction_2 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 0, invoice_id: @invoice_2.id)
    @transaction_3 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 0, invoice_id: @invoice_3.id)
    @transaction_4 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 0, invoice_id: @invoice_4.id)
    @transaction_5 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 0, invoice_id: @invoice_5.id)
    @transaction_6 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 0, invoice_id: @invoice_6.id)
    @transaction_7 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 1, invoice_id: @invoice_7.id)
    @item1 = Item.create!(
      id: 1,
      name: "Item Qui Esse",
      description:
      "Nihil autem sit odio inventore deleniti.",
      unit_price: 75107,
      merchant_id: @merchant1.id
      )
      
      @item2 = Item.create!( 
        id: 2,
        name: "Item Autem Minima",
        description:
        "Cumque consequuntur ad.",
        unit_price: 67076,
        merchant_id: @merchant1.id
        )
        
        @invoice_item1 = InvoiceItem.create!(quantity: 5, unit_price: 10, status: 1, item_id: @item1.id, invoice_id: @invoice_1.id)
        @invoice_item2 = InvoiceItem.create!(quantity: 3, unit_price: 15, status: 0, item_id: @item2.id, invoice_id: @invoice_1.id)
        @invoice_item3 = InvoiceItem.create!(quantity: 18, unit_price: 10, status: 1, item_id: @item1.id, invoice_id: @invoice_2.id)
        @invoice_item4 = InvoiceItem.create!(quantity: 7, unit_price: 15, status: 0, item_id: @item2.id, invoice_id: @invoice_3.id)
      end

  describe "As a merchant" do
    #User Story 1
    describe "When I visit my merchant dashboard" do
      it "I see the name of my merchant" do

        visit "/merchants/#{@merchant1.id}/dashboard"
        expect(page).to have_content(@merchant1.name)
        expect(page).to_not have_content(@merchant2.name)
      end
      
      it "I see a link to my merchant items index" do 
        
        visit "/merchants/#{@merchant1.id}/dashboard"
        
        expect(page).to have_link("Items")
        click_link("Items")
        
        expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
      end

      it "I see a link to my merchant invoices index" do 
        visit "/merchants/#{@merchant1.id}/dashboard"
        
        expect(page).to have_link("Invoices")
        click_link("Invoices")
        
        expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices")
      end

      describe "Merchant Dashboard Statistics - Favorite Customers" do
        #User Story 3
        it "shows names of the top five customers" do
          visit "/merchants/#{@merchant1.id}/dashboard"
          expect(page).to have_content("Top 5 Customers")
          expect(page).to have_content("Susan Robinson Successful Transactions: 1")
          expect(page).to have_content("Jessica Simpson Successful Transactions: 1")
          expect(page).to have_content("Harry Potter Successful Transactions: 1")
          expect(page).to have_content("Ron Weasley Successful Transactions: 1")
          expect(page).to have_content("Nicole Johnson Successful Transactions: 1")
          expect(page).to_not have_content("Jackie Chan")
          expect(page).to_not have_content("John Jacobs")
        end
      end

      describe "Merchant Dashboard ready to ship" do
        it 'tells items that are ready to ship' do
          visit "/merchants/#{@merchant1.id}/dashboard"
          expect(page).to have_content("Items Ready To Ship")
          within("section#ready_to_ship") do
            expect(page).to have_content(@item1.name)
            expect(page).to_not have_content(@item2.name)
            expect(page).to have_link("Invoice #{@invoice_item1.invoice_id}")
            click_link("Invoice #{@invoice_item1.invoice_id}")
            expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice_item1.invoice_id}")
          end
        end
      end
    end
  end
end