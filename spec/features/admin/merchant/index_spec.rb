require "rails_helper"

RSpec.describe "Admin Merchants Index", type: feature do 
  it "displays the name of each merchant in the system" do 

    merch1 = Merchant.create!({name: "Schroeder-Jerde"})
    merch2 = Merchant.create!({name: "Klein, Rempel and Jones"})
    merch3 = Merchant.create!({name: "Willms and Sons"})
    merch4 = Merchant.create!({name: "Cummings-Thiel"})
    merch5 = Merchant.create!({name: "Williamson Group"})
    merch6 = Merchant.create!({name: "Bernhard-Johns"})
    merch7 = Merchant.create!({name: "Osinski, Pollich and Koelpin"})
    merch8 = Merchant.create!({name: "Hand-Spencer"})

    visit "/admin/merchants"

    expect(page).to have_content("Name: #{merch1.name}")
    expect(page).to have_content("Name: #{merch2.name}")
    expect(page).to have_content("Name: #{merch3.name}")
    expect(page).to have_content("Name: #{merch4.name}")
    expect(page).to have_content("Name: #{merch5.name}")
    expect(page).to have_content("Name: #{merch6.name}")
    expect(page).to have_content("Name: #{merch7.name}")
    expect(page).to have_content("Name: #{merch8.name}")
  end
  
end 