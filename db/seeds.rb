# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! name: 'Campaigning Catherine',
                    email: 'cc@example.com',
                    password:              'letmein',
                    password_confirmation: 'letmein'

user.confirmation_token = nil
user.confirmed_at = Time.now
user.save

puts 'New user created: ' << user.name
