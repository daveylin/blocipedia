# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
 require 'faker'
 
# Create Users
5.times do
  user = User.new(
    username:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: 'TestingPass'
  )
  user.skip_confirmation!
  user.save!
end

admin = User.new(
  username: 'Admin User',
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)
admin.skip_confirmation!
admin.save!

standard = User.new(
  username: 'Standard User',
  email:    'standard@example.com',
  password: 'helloworld',
  role:     'standard'
)
standard.skip_confirmation!
standard.save!

premium = User.new(
  username: 'Premium User',
  email:    'premium@example.com',
  password: 'helloworld',
  role:     'premium'
)
premium.skip_confirmation!
premium.save!

users = User.all

60.times do
  wiki = Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    user: users.sample,
    private: 'N',
    created_at: Faker::Time.between(60.days.ago, Time.now)
    )
  wiki.save!
end