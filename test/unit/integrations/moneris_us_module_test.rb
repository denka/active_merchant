require 'test_helper'

class MonerisUsModuleTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def test_notification_method
    assert_instance_of MonerisUs::Notification, MonerisUs.notification('name=cody')
  end
end
