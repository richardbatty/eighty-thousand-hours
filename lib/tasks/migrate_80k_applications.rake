desc 'migrate 80k application fields from Member to new model EightyThousandHoursApplication'
task :migrate_80k_applications => :environment do
  Member.all.each do |member|
    begin
      default_str = "*** applied before this field was introduced ***"
      new_80k_app = EightyThousandHoursApplication.new do |e|
        e.member_id = member.id

        # no longer need default text in fields so don't copy it over!
        # also don't copy over a nil value, as validation will fail

        if member.apply_occupation == default_str || member.apply_occupation.nil?
          e.occupation = "n/a"
        else
          e.occupation = member.apply_occupation
        end

        if member.apply_career_plans == default_str || member.apply_career_plans.nil?
          e.career_plans = "n/a"
        else
          e.career_plans = member.apply_career_plans
        end

        if member.apply_reasons_for_joining == default_str || member.apply_reasons_for_joining.nil?
          e.reasons_for_joining = "n/a"
        else
          e.reasons_for_joining = member.apply_reasons_for_joining
        end

        if member.apply_spoken_to_existing_member == default_str || member.apply_spoken_to_existing_member.nil?
          e.spoken_to_existing_member = "n/a"
        else
          e.spoken_to_existing_member = member.apply_spoken_to_existing_member
        end

        if member.donation_percentage == default_str || member.donation_percentage.nil?
          e.donation_percentage = "n/a"
        else
          e.donation_percentage = member.donation_percentage
        end
        e.donation_percentage_comment = member.donation_percentage_comment

        if member.donation_average_income == default_str || member.donation_average_income.nil?
          e.average_income = "n/a"
        else
          e.average_income = member.donation_average_income
        end
        e.average_income_comment = member.donation_average_income_comment

        if member.donation_hic_activity_hours == default_str || member.donation_hic_activity_hours.nil?
          e.hic_activity_hours = "n/a"
        else
          e.hic_activity_hours = member.donation_hic_activity_hours
        end
        e.hic_activity_hours_comment = member.donation_hic_activity_hours_comment

        e.doing_good_inspiring  = member.doing_good_inspiring
        e.doing_good_research   = member.doing_good_research
        e.doing_good_prophil    = member.doing_good_prophil
        e.doing_good_innovating = member.doing_good_innovating
        e.doing_good_improving  = member.doing_good_improving

        # didn't exist in old application
        e.causes_givewell      = false
        e.causes_gwwc          = false
        e.causes_international = false
        e.causes_xrisk         = false
        e.causes_meta          = false
        e.causes_domestic      = false
        e.causes_animal        = false
        e.causes_political     = false
        e.causes_comment       = false

        e.pledge = true
      end

      new_80k_app.save

      member.eighty_thousand_hours_application = new_80k_app
      member.save

      puts "Member #{member.name} successfully migrated"
    rescue
      puts "Error migrating #{member.name}"
    end
  end
end
