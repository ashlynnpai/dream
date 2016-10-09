Fabricator(:place) do
  name { Faker::Lorem.words(3).join("") }
  address 'New York, NY'
  description { Faker::Lorem.paragraph(3) }
end