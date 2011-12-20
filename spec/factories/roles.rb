FactoryGirl.define do
  %w[admin donation_admin blogger].each do |role|
    factory role, :class => Role do
      name role.to_s.camelize
    end
  end
end