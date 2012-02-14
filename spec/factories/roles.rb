FactoryGirl.define do
  %w[admin member_admin donation_admin web_admin blog_admin].each do |role|
    factory role, :class => Role do
      name role.to_s.camelize
    end
  end
end
