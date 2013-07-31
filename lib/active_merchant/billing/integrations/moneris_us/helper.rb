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

          mapping :customer,
            first_name: 'od_bill_firstname',
            last_name: 'od_bill_lastname',
            email: 'client_email',
            phone: 'od_bill_phone',
            id: 'cust_id'

          mapping :billing_address,
            city: 'od_bill_city',
            address1: 'od_bill_address',
            state: 'od_bill_state',
            zip: 'od_bill_zipcode',
            country: 'od_bill_country',
            company: 'od_bill_company'

          mapping :ship_to_address,
            first_name: 'od_ship_firstname',
            last_name: 'od_ship_lastname',
            address: 'od_ship_address',
            city: 'od_ship_city',
            state: 'od_ship_state',
            zip: 'od_ship_zipcode',
            country: 'od_ship_country',
            phone: 'od_ship_phone',
            fax: 'od_ship_fax'

          mapping :notify_url, 'notify_url'
          mapping :cancel_return_url, ''
          mapping :description, 'note'
          mapping :tax, 'li_taxes'
          mapping :shipping, 'li_shipping'

          # Uses Pass Through Product Parameters to pass in lineitems.
          def line_item(params = {})
            (max_existing_line_item_id = form_fields.keys.map do |key|
              i = key.to_s[/^li_.+(\d+)$/, 1]
              (i && i.to_i)
            end.compact.max || 0)

            line_item_id = max_existing_line_item_id + 1
            params.each do |key, value|
              add_field("li_#{key}#{line_item_id}", value)
            end
          end
        end
      end
    end
  end
end
