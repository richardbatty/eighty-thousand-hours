# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

puts 'SETTING UP ROLES'
["Admin","Member","Blogger"].each do |r|
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


puts 'CREATING MEMBER PROFILE'

profile = MemberProfile.create! background: "I'm a lumberjack and I'm ok.",
                                career_plans: "Work and then die.",
                                location: "Oxford, England:"
profile.user = User.find_by_name("Member Michael");
profile.save

