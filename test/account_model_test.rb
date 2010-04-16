require "test_helper"

class AccountModelTest < ActiveSupport::TestCase
  context "Creating an AccountModel based model without a current account" do
    setup do
      Account.clear_current_account()
    end
    should "fail" do
      assert_raises ActiveRecord::RecordInvalid do
        OrganizationalUnit.create! :name=>"an OU"
      end
    end
  end
  context "Creating an AccountModel based model with a current account" do
    setup do
      Account.set_current_account(Account.first || Account.create!(:name=>"Lieutenant Dan"))
    end
    should "automatically set the account" do
      ou = OrganizationalUnit.create! :name=>"an OU"
      assert_equal Account.current, ou.account
    end
  end
end