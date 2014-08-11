# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

CreatesEvent.new(name: "Neil Patrick Harris",
    description: "Neil Patrick Harris (How I Met Your Mother)
      guest-stars on a one-of-a kind Muppet show",
    performance_time: "October 4, 2014",
    capacity: 250).create

CreatesEvent.new(name: "Kristin Chenoweth",
    description: "Kristin Chenoweth (Wicked, Pushing Daisies)
      guest-stars on a one-of-a kind Muppet show",
    performance_time: "October 11, 2014",
    capacity: 250).create

CreatesEvent.new(name: "Weird Al Yankovic",
    description: "Weird Al Yankovic (Mandatory Fun) sings his way through the Muppet Show",
    performance_time: "October 18, 2014",
    capacity: 250).create

CreatesEvent.new(name: "",
    description: "",
    performance_time: "October 25, 2014",
    capacity: 250).create
