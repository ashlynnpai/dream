unesco = Category.create(name: "unesco")
Place.all.each do |place|
  place.categories << unesco
end