desc 'move all Member fields to User'
task :migrate_members_to_users => :environment do
  Member.all.each do |member|
    user = member.user

    fields = [:location,
              :confirmed,
              :avatar_file_name,
              :avatar_content_type,
              :avatar_file_size,
              :avatar_updated_at,
              :phone,
              :on_team,
              :team_role_id,
              :external_twitter,
              :external_facebook,
              :external_linkedin,
              :real_name]

    # no longer need default text in fields so don't copy it over!
    fields.each do |f|
      user[f] = member[f]
    end

    member.eighty_thousand_hours_profile.user = user
    member.eighty_thousand_hours_profile.save

    member.eighty_thousand_hours_application.user = user
    member.eighty_thousand_hours_application.save

    begin
      user.save
      puts "Saved #{member.name}"
    rescue
      puts "Failed to save #{member.name}"
    end
  end
end
