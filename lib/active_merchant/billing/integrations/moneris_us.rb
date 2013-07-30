require File.dirname(__FILE__) + '/moneris_us/helper.rb'
require File.dirname(__FILE__) + '/moneris_us/notification.rb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module MonerisUs

        mattr_accessor :production_url, :test_url
        self.test_url = 'https://esplusqa.moneris.com/DPHPP/index.php'
        self.production_url = 'https://esplus.moneris.com/DPHPP/index.php'

        def self.service_url
          case ActiveMerchant::Billing::Base.integration_mode
          when :production
            self.production_url
          when :test
            self.test_url
          else
            raise StandardError, "Integration mode set to an invalid value: #{mode}"
          end
        end

        def self.notification(post)
          Notification.new(post)
        end
      end
    end
  end
end
