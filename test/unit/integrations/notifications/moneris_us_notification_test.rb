require 'test_helper'

class MonerisUsNotificationTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def setup
    @moneris_us = MonerisUs::Notification.new(http_raw_data)
  end

  def test_accessors
    assert @moneris_us.complete?
    assert_equal "", @moneris_us.status
    assert_equal "", @moneris_us.transaction_id
    assert_equal "", @moneris_us.item_id
    assert_equal "", @moneris_us.gross
    assert_equal "", @moneris_us.currency
    assert_equal "", @moneris_us.received_at
    assert @moneris_us.test?
  end

  def test_compositions
    assert_equal Money.new(3166, 'USD'), @moneris_us.amount
  end

  # Replace with real successful acknowledgement code
  def test_acknowledgement

  end

  def test_send_acknowledgement
  end

  def test_respond_to_acknowledge
    assert @moneris_us.respond_to?(:acknowledge)
  end

  private
  def http_raw_data
    ""
  end
end
