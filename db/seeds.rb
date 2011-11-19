# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

puts 'SETTING UP ROLES'
["Admin","Blogger"].each do |r|
  r = Role.create! name: r
  puts 'Created Role: ' << r.name
end

puts 'SETTING UP DEFAULT USER LOGIN'
[
  { :name => "Campaigner Cat", :email => "cc@eg.com" },
  { :name => "Member Michael", :email => "mm@eg.com" },
  { :name => "Blogging Billy", :email => "bb@eg.com", :roles => ["Blogger"] },
  { :name => "Admin Anthonio", :email => "aa@eg.com", :roles => ["Admin"] }
].each do |u|
  user = User.create! name:  u[:name],
                      email: u[:email],
                      password:              'letmein',
                      password_confirmation: 'letmein'

  if u[:roles]
    u[:roles].each do |r|
      role = Role.find_by_name r
      user.roles << role
    end
  end

  user.confirm!
  puts 'New user created: ' << user.name
end


puts 'CREATING MEMBER PROFILES'
user = User.find_by_name("Member Michael");
member = Member.create! background: "I am Member Michael. I love careers, I love ethics, and I love websites. This is great!",
                          career_plans: "Become King of England.",
                          location: "Oxford, England:",
                          user: user
puts "Created profile...trying to link to user..."
#user.profile = profile
#user.save
puts 'Added profile for Member Michael'

user = User.find_by_name("Blogging Billy");
member = Member.create! background: "I am Blogging Billy. I've been blogging about high impact careers since I was 3 years olds.",
                          career_plans: "I plan to blog myself senseless.",
                          location: "London, England:",
                          user: user
puts "Created profile...trying to link to user..."
#user.profile = profile
#user.save
puts 'Added profile for Blogging Billy'

