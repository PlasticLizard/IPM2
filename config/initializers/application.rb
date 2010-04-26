#if Rails.env == "development"
#  Account.set_current_account(Account.first)
#  puts "The current account has been set to #{Account.current.name}"
#end