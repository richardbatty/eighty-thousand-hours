FactoryGirl.define do
  factory :member do
    user
    background "Pirate"
    career_plans "Benevolently dictate the Seven Seas"
    apply_occupation "Ship's Mate"
    apply_career_plans "Cap'n"
    apply_reasons_for_joining "Felt bad for running everyone through and plundering their booty,\
                               and wanted to give something back."
    apply_heard_about_us "LinkedIn"
    apply_spoken_to_existing_member "Ay"
  end
end
