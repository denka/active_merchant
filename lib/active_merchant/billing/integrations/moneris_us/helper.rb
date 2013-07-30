module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module MonerisUs
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          # Replace with the real mapping
          mapping :account, 'hpp_id'
          mapping :credential2, 'hpp_key'
          mapping :amount, 'amount'

          mapping :order, 'order_no'

          mapping :customer, :first_name => 'od_bill_firstname',
                             :last_name  => 'od_bill_lastname',
                             :email      => 'client_email',
                             :phone      => 'od_bill_phone'

          mapping :billing_address, :city     => 'od_bill_city',
                                    :address1 => 'od_bill_address',
                                    :state    => 'od_bill_state',
                                    :zip      => 'od_bill_zipcode',
                                    :country  => 'od_bill_country',
                                    :company  => 'od_bill_company'

          mapping :notify_url, 'notify_url'
          mapping :cancel_return_url, ''
          mapping :description, 'note'
          mapping :tax, 'li_taxes'
          mapping :shipping, 'li_shipping'
        end
      end
    end
  end
end
