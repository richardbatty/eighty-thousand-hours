desc 'migrate 80k application fields to new model EightyThousandApplication'
task :migrate_80k_application_fields => :environment do
  Member.all.each do |member|
    begin
      default_str = "*** applied before this field was introduced ***"
      new_80k_app = EightyThousandApplication.new do |e|
        e.member_id = member.id

        # no longer need default text in fields so don't copy it over!
        if member.apply_occupation != default_str
          e.occupation = member.apply_occupation
        end

        if member.apply_career_plans != default_str
          e.career_plans = member.apply_career_plans
        end

        if member.apply_reasons_for_joining != default_str
          e.reasons_for_joining = member.apply_reasons_for_joining
        end

        if member.apply_spoken_to_existing_member != default_str
          e.spoken_to_existing_member = member.apply_spoken_to_existing_member
        end

        if member.donation_percentage != default_str
          e.donation_percentage = member.donation_percentage
        end
        e.donation_percentage_comment = member.donation_percentage_comment

        if member.donation_average_income != default_str
          e.average_income = member.donation_average_income
        end
        e.average_income_comment = member.donation_average_income_comment

        if member.donation_hic_activity_hours != default_str
          e.hic_activity_hours = member.donation_hic_activity_hours
        end
        e.hic_activity_hours_comment = member.donation_hic_activity_hours_comment

        e.doing_good_inspiring = member.doing_good_inspiring
        e.doing_good_research = member.doing_good_research
        e.doing_good_prophil = member.doing_good_prophil
        e.doing_good_innovating = member.doing_good_innovating
        e.doing_good_improving = member.doing_good_improving

        e.causes_givewell = member.donation_causes_givewell
        e.causes_gwwc = member.donation_causes_gwwc
        e.causes_international = member.donation_causes_international
        e.causes_xrisk = member.donation_causes_xrisk
        e.causes_meta = member.donation_causes_meta
        e.causes_domestic = member.donation_causes_domestic
        e.causes_animal = member.donation_causes_animal
        e.causes_political = member.donation_causes_political
        e.causes_comment = member.donation_causes_comment
      end

      new_80k_app.save;

      member.eth_application = new_80k_app;
      member.save;

      puts "Member #{member.name} successfully migrated"
    rescue
      puts "Error migrating #{member.name}"
    end
  end
end
