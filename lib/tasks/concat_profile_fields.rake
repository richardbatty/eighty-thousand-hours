desc 'concatenate multiple old fields into one new field'
task :concat_profile_fields => :environment do
  EtkhProfile.all.each do |profile|
    background = profile.background
    career_plans = profile.career_plans
    inspiration = profile.inspiration
    interesting_fact = profile.interesting_fact
    occupation = profile.occupation

    if !career_plans.nil?
      background = background + "

# Career plans
" + career_plans
    end

    if !inspiration.nil?
      background = background + "

# Inspiration
" + inspiration
    end

    if !occupation.nil?
      background = background + "

# Occupation
" + occupation
    end


    if !interesting_fact.nil?
      background = background + "

# Interesting fact
" + interesting_fact
    end

    profile.background = background

    begin
      profile.save

      puts "Member #{profile.name} successfully migrated"
    rescue
      puts "Error saving #{profile.name} member"
    end
  end
end
