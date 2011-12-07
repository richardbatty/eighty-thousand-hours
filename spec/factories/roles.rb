FactoryGirl.define do
  %w[admin donation_admin blogger].each do |role|
    factory role, :class => Role do
      name role
    end
  end
end