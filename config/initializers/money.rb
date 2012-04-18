require 'money'
require 'money/bank/google_currency'

# set default bank to instance of GoogleCurrency
Money.default_bank = Money::Bank::GoogleCurrency.new
