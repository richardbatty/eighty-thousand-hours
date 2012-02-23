desc 'migrate 80k profile fields from Member to new model EightyThousandHoursProfile'
task :migrate_80k_profiles => :environment do
  Member.all.each do |member|
    default_str = "*** applied before this field was introduced ***"
    new_80k_profile = EightyThousandHoursProfile.new do |p|
      p.member_id = member.id

      fields = [:inspiration,
                :interesting_fact,
                :background,
                :career_plans,
                :occupation,
                :organisation,
                :organisation_role]

      # no longer need default text in fields so don't copy it over!
      fields.each do |f|
        p[f] = member[f] unless member[f] == default_str
      end

      p.contacted_by               = member.contacted_by
      p.contacted_date             = member.contacted_date
      p.confirmed                  = member.confirmed
      p.public_profile             = member.public_profile

      p.doing_good_inspiring       = member.doing_good_inspiring
      p.doing_good_research        = member.doing_good_research
      p.doing_good_philanthropy    = member.doing_good_philanthropy
      p.doing_good_prophilanthropy = member.doing_good_prophilanthropy
      p.doing_good_innovating      = member.doing_good_innovating
      p.doing_good_improving       = member.doing_good_improving

      # this is useful info
      p.created_at = member.created_at
    end

    begin
      new_80k_profile.save
    rescue
      puts "Failed to save profile for #{member.name}"
    end

    begin
      member.eighty_thousand_hours_profile = new_80k_profile
      member.save

      puts "Member #{member.name} successfully migrated"
    rescue
      puts "Error saving #{member.name} member"
    end
  end
end
