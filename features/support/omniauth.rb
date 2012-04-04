module OmniAuthHelper
  def set_omniauth(opts = {})
    default = { :provider => :facebook,
                :uid     => "1234",
                :info => {
                  :name       => 'Fake McName',
                  :email      => "foobar@example.com",
                  :first_name => "Fake",
                  :last_name  => "McName"
                }
              }

    credentials = default.merge(opts)
    provider = credentials[:provider]

    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[provider] = {
      'uid'      => credentials[:uid],
      'provider' => credentials[:provider],
      'info'     => { 'name' => credentials[:info][:name],
                      'email' => credentials[:info][:email] }
    }
  end

  def set_invalid_omniauth(opts = {})

    credentials = { :provider => :facebook,
                    :invalid  => :invalid_crendentials
                   }.merge(opts)

    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[credentials[:provider]] = credentials[:invalid]

  end
end

include OmniAuthHelper

Before('@omniauth') do
  set_omniauth
end