Fabricator(:photo) do
  caption { Faker::Lorem.paragraph(2) }
  owner "Photo Taker"
  copyright "CC by 2.0"
  image { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/tower.jpg')), 'image/jpeg') }
end


