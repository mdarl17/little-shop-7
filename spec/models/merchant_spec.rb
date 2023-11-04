require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoices).through(:items) }
  end

  describe "#top_5_customers" do
    it "displays the top 5 customers" do
      @merchant1 = Merchant.create!(name: "Hannah's Handbags")
      @merchant2 = Merchant.create!(name: "Jason's Furniture")

      @customer1 = Customer.create!(first_name: "John", last_name: "Jacobs")
      @customer2 = Customer.create!(first_name: "Susan", last_name: "Robinson")
      @customer3 = Customer.create!(first_name: "Jessica", last_name: "Simpson")
      @customer4 = Customer.create!(first_name: "Harry", last_name: "Potter")
      @customer5 = Customer.create!(first_name: "Ron", last_name: "Weasley")
      @customer6 = Customer.create!(first_name: "Nicole", last_name: "Johnson")
      @customer7 = Customer.create!(first_name: "Jackie", last_name: "Chan")
      
      @invoice1 = Invoice.create!(status: 0, customer_id: @customer1.id)
      @invoice2 = Invoice.create!(status: 2, customer_id: @customer2.id)
      @invoice3 = Invoice.create!(status: 2, customer_id: @customer3.id)
      @invoice4 = Invoice.create!(status: 2, customer_id: @customer4.id)
      @invoice5 = Invoice.create!(status: 2, customer_id: @customer5.id)
      @invoice6 = Invoice.create!(status: 2, customer_id: @customer6.id)
      @invoice7 = Invoice.create!(status: 0, customer_id: @customer7.id)
      @invoice8 = Invoice.create!(status: 0, customer_id: @customer7.id)

      @transaction1 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 1, invoice_id: @invoice1.id)
      @transaction2 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 0, invoice_id: @invoice2.id)
      @transaction3 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 0, invoice_id: @invoice3.id)
      @transaction4 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 0, invoice_id: @invoice4.id)
      @transaction5 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 0, invoice_id: @invoice5.id)
      @transaction6 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 0, invoice_id: @invoice6.id)
      @transaction7 = Transaction.create!(credit_card_number: 123456789, credit_card_expiration_date: "11/26", result: 1, invoice_id: @invoice7.id)

      top_5 = @merchant1.top_5_customers

      expect(top_5).to eq([@customer2, @customer3, @customer4, @customer5, @customer6])
      expect(top_5).to_not include(@customer1)
      expect(top_5).to_not include(@customer7)
    end

    describe "top_5_items" do
      it "displays the best selling items by revenue" do
        @merchant1 = Merchant.create!(name: "Hannah's Handbags")
        @merchant2 = Merchant.create!(name: "Arnold's Armoire")
        @item1 = Item.create!(
          name: "Item Qui Esse",
          description:
          "Nihil autem sit odio inventore deleniti.",
          unit_price: 75107,
          merchant_id: @merchant1.id
        )
        @item2 = Item.create!( 
          name: "Item Autem Minima",
          description:
          "Cumque consequuntur ad.",
          unit_price: 67076,
          merchant_id: @merchant1.id
        )
        @item3 = Item.create!(
          name: "Item Ea Voluptatum",
          description:
          "Sunt officia eum qui molestiae. Nesciunt quidem cupiditate reiciendis est commodi non. Atque eveniet sed. Illum excepturi praesentium reiciendis voluptatibus eveniet odit perspiciatis. Odio optio nisi rerum nihil ut.",
          unit_price: 32301,
          merchant_id: @merchant1.id
        )
        @item4 = Item.create!(
          name: "Item Nemo Facere",
          description: "Sunt eum id eius magni consequuntur delectus veritatis.",
          unit_price: 4291,
          merchant_id: @merchant2.id
        )
        # @item5 = Item.create!(
        #   id: 5,
        #   name: "Item Expedita Aliquam",
        #   description: "Voluptate aut labore qui illum tempore eius. Corrupti cum et rerum. Enim illum labore voluptatem dicta consequatur. Consequatur sunt consequuntur ut officiis.",
        #   unit_price: 68723,
        #   merchant_id: @merchant2.id
        # )
        @item5 = Item.create!(name: "Gold Ring", unit_price: 1200, merchant_id: @merchant1.id, description: "14k Gold")
        @item6 = Item.create!(name: "Silver Ring", unit_price: 900, merchant_id: @merchant1.id, description: "Pure Silver")
        @item7 = Item.create!(name: "Gold Necklace", unit_price: 1400, merchant_id: @merchant1.id, description: "10k Gold")
        @item8 = Item.create!(name: "Silver Necklace", unit_price: 1000, merchant_id: @merchant1.id, description: "Pure Silver")
        @item9 = Item.create!(name: "Hair Clip", unit_price: 25, merchant_id: @merchant1.id, description: "Black Plastic")
        @item10 = Item.create!(name: "Hoop Earrings", unit_price: 125, merchant_id: @merchant1.id, description: "Bonze")

        @customer1 = Customer.create!(first_name: "John", last_name: "Jacobs")
        @customer2 = Customer.create!(first_name: "Susan", last_name: "Robinson")
        @customer3 = Customer.create!(first_name: "Jessica", last_name: "Simpson")
        @customer4 = Customer.create!(first_name: "Harry", last_name: "Potter")
        @customer5 = Customer.create!(first_name: "Ron", last_name: "Weasley")
        @customer6 = Customer.create!(first_name: "Nicole", last_name: "Johnson")

        @invoice1 = Invoice.create!(status: 2, customer_id: @customer1.id)
        @invoice2 = Invoice.create!(status: 2, customer_id: @customer2.id)
        @invoice3 = Invoice.create!(status: 2, customer_id: @customer3.id)
        @invoice4 = Invoice.create!(status: 2, customer_id: @customer4.id)
        @invoice5 = Invoice.create!(status: 2, customer_id: @customer5.id)
        @invoice6 = Invoice.create!(status: 2, customer_id: @customer6.id)
        @invoice7 = Invoice.create!(status: 2, customer_id: @customer6.id)
        @invoice8 = Invoice.create!(status: 2, customer_id: @customer6.id)
        @invoice9 = Invoice.create!(status: 2, customer_id: @customer6.id)
        @invoice10 = Invoice.create!(status: 2, customer_id: @customer6.id)
        @invoice11 = Invoice.create!(status: 2, customer_id: @customer6.id)
        @invoice12 = Invoice.create!(status: 2, customer_id: @customer6.id)

        @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 111, status: 1) 
        @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 1, unit_price: 345, status: 1) 
        @invoice_item3 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice3.id, quantity: 1, unit_price: 420, status: 1) 
        @invoice_item4 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice4.id, quantity: 1, unit_price: 345, status: 1) 
        @invoice_item5 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice5.id, quantity: 1, unit_price: 420, status: 1) 
        @invoice_item6 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice6.id, quantity: 1, unit_price: 345, status: 1) 
        @invoice_item7 = InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice7.id, quantity: 1, unit_price: 711, status: 1)
        @invoice_item8 = InvoiceItem.create!(item_id: @item9.id, invoice_id: @invoice8.id, quantity: 1, unit_price: 711, status: 1)
        @invoice_item9 = InvoiceItem.create!(item_id: @item10.id, invoice_id: @invoice9.id, quantity: 1, unit_price: 345, status: 1)
        @invoice_item10 = InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice10.id, quantity: 1, unit_price: 126, status: 1)
        @invoice_item11 = InvoiceItem.create!(item_id: @item9.id, invoice_id: @invoice11.id, quantity: 1, unit_price: 123, status: 1)
        @invoice_item12 = InvoiceItem.create!(item_id: @item10.id, invoice_id: @invoice12.id, quantity: 1, unit_price: 345, status: 1)

        @transaction1 = Transaction.create!(invoice_id: @invoice1.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
        @transaction2 = Transaction.create!(invoice_id: @invoice2.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
        @transaction3 = Transaction.create!(invoice_id: @invoice3.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
        @transaction4 = Transaction.create!(invoice_id: @invoice4.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
        @transaction5 = Transaction.create!(invoice_id: @invoice5.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
        @transaction6 = Transaction.create!(invoice_id: @invoice6.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
        @transaction7 = Transaction.create!(invoice_id: @invoice7.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
        @transaction8 = Transaction.create!(invoice_id: @invoice8.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
        @transaction9 = Transaction.create!(invoice_id: @invoice9.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
        @transaction10 = Transaction.create!(invoice_id: @invoice10.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
        @transaction11 = Transaction.create!(invoice_id: @invoice11.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)
        @transaction12 = Transaction.create!(invoice_id: @invoice12.id, credit_card_number: "1234567812345678", credit_card_expiration_date: "10/26", result: 0)

        @top_items = @merchant1.top_5_items

        expect(@top_items).to match_array([@item1, @item2, @item8, @item9, @item10])
        expect(@top_items).to_not include(@item4)
        expect(@top_items).to_not include(@item5)
        expect(@top_items).to_not include(@item6)
        expect(@top_items).to_not include(@item7)
      end
    end
  end

  describe "#button_text" do 
    it "if merchant status is 'enabled' it returns 'Disable,' otherwise it returns 'enable'" do 
      merchants = create_list(:merchant, 2)
      merchant_1 = merchants.first
      merchant_2 = merchants.last
      merchant_2.update!({status: 0})

      expect(merchant_1.button_text).to eq("Disable")
      expect(merchant_2.button_text).to eq("Enable")
    end
  end

  describe "#enabled?" do
    before(:each) do 
     end
    it "returns true if the merchan's status is 'enabled' and false if merchant status is 'disabled'" do 
      merchants = create_list(:merchant, 2)
      merchant_1 = merchants.first
      merchant_2 = merchants.last
      merchant_2.update!({status: 0})

      expect(merchant_1.enabled?).to eq(true)
      expect(merchant_2.enabled?).to eq(false)
    end
  end

  describe "#toggle_status" do 
    it "returns the integer 0 if merchant status is 'enabled' and integer value 1 if merchant status is 'disabled'" do 
      merchants = create_list(:merchant, 2)
      merchant_1 = merchants.first
      merchant_2 = merchants.last
      merchant_2.update!({status: 0})

      expect(merchant_1.toggle_status).to eq(0)
      expect(merchant_2.toggle_status).to eq(1)
    end
  end

  describe "@sort_by_name" do 
    it "sorts the merchants alphabetically ascending by name" do
      merchant_1 = Merchant.create!({name: "Wilson & Co."})
      merchant_2 = Merchant.create!({name: "Andersen, Anderson, & Anderssen"})
      merchant_3 = Merchant.create!({name: "Rumpke & Assoc., LLC"})
      merchant_4 = Merchant.create!({name: "Liebowitz & Sons, Inc."})
      merchant_5 = Merchant.create!({name: "McClaren Group"})

      expect(Merchant.sort_by_name).to eq([merchant_2, merchant_4, merchant_5, merchant_3, merchant_1])
    end
  end

end