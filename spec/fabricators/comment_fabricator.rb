Fabricator(:comment) do
  message { Faker::Lorem.paragraph(3) }
  rating { (1..5).to_a.sample }
end
