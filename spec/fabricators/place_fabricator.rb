Fabricator(:place) do
  name { Faker::Lorem.words(3).join("") }
  address { Faker::Address.street_address }
  description { Faker::Lorem.paragraph(3) }
end