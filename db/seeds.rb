# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Movie.delete_all

Movie.create(title: "Hyde Park on Hudson", year: 2012, description: "Hyde Park on Hudson", rt_id: 771242341)
Movie.create(title: "The Sorcerer and the White Snake", year: 2013, description: "The Sorcerer and the White Snake", rt_id: 771252631)
Movie.create(title: "Bad Kids Go to Hell", year: 2012, description: "Bad Kids Go to Hell", rt_id: 771311824)
Movie.create(title: "The Haunting in Connecticut 2: Ghosts of Georgia", year: 2013, description: "The Haunting in Connecticut 2: Ghosts of Georgia", rt_id: 771323314)
Movie.create(title: "Django Unchained", year: 2012, description: "Django Unchained", rt_id: 771245718)
Movie.create(title: "Dragon", year: 2012, description: "Dragon", rt_id: 771242451)
Movie.create(title: "A Monster in Paris", year: 2011, description: "A Monster in Paris", rt_id: 771234642)
Movie.create(title: "Save The Date", year: 2012, description: "Save The Date", rt_id: 771267280)
Movie.create(title: "Not Suitable for Children", year: 2012, description: "Not Suitable for Children", rt_id: 771306257)
Movie.create(title: "Gangster Squad", year: 2013, description: "Gangster Squad", rt_id: 771256131)