namespace :db do
  # defines a db:populate task to create movies
  desc "Pulls a dozen movies from the last 12 mo and adds them to the DB"
  task populate :environment do
    Movie.create!(name: "name of movie",
                   description: "description of movie",
                   year: 2012)
    12.times do |n|
      title = Faker::Name.title
      description = Faker::Name.desc
      year =  Faker::Year.year
    end
  end
end
