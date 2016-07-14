Fabricator(:photo) do
  caption { Faker::Lorem.paragraph(2) }
  owner "Photo Taker"
  copyright "CC by 2.0"
end


