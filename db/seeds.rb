# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! name: 'Campaigning Cat',
                    email: 'cc@example.com',
                    password:              'letmein',
                    password_confirmation: 'letmein'

user.confirm!

puts 'New user created: ' << user.name
