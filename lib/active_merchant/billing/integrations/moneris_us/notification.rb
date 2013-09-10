module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module MonerisUs
        class Notification < ActiveMerchant::Billing::Integrations::Notification

          def initialize(post, options = {})
            super
            @options[:time_zone] ||= "-05:00"
          end

          def canceled?
            params['cancel'].present?
          end

          def approved?
            params['response_code'].try(:<, 50)
          end

          def failed?
            params['response_code'].nil?
          end

          def declined?
            params['response_code'].try(:>=, 50)
          end

          def order_id
            params["order_no"]
          end

          # gateway transaction identifier
          def transaction_id
            params['txn_num']
          end

          # cardholder name
          def cardholder
            params['cardholder']
          end

          def card_type
            params['card_type']
          end

          # obfuscated card number
          def card_num
            params['card_num']
          end

          # tries to make 2 digit year into a full year
          def card_expiration_date
            Date.parse([params["exp_year"],params["exp_month"]].join("-"),comp=true) if params['exp_year'].present? and params['exp_month'].present?
          end

          def eci
            params["crypt_type"]
          end

          # 18 character string
          # should be stored by merchant
          # must displayed on receipts
          # breakdown:
          # 640123450010690030
          # aaaaaaaabbbcccddd
          # a - terminal id
          # b - shift number
          # c - batch number
          # d - transaction number within batch
          def reference_number
            params['ref_num']
          end

          # used in transaction verification feature
          def verify_key
            params['verify_key']
          end

          def auth_code
            params['auth_code']
          end

          # When was this payment received by the client.
          def received_at
            # @TODO mangle this to return a DateTime
            Time.parse("%sT%s%s" % [params['txn_date'],params['txn_time'],@options[:time_zone]]) if params['txn_date'].present? and params['txn_time'].present?
          end

          def payer_email
            params['client_email']
          end

          # the money amount we received in X.2 decimal.
          def gross
            params['amount']
          end

          def result
            params['result']
          end

          def message
            params['message']
          end

          def transaction_date
            received_at
          end

          def response_code
            params['response_code']
          end

          def status
            case params['response_code']
            when 0...49
              'Approved'
            when 54
              'Expired Card'
            when 55...56
              'Card not Supported'
            when 70...75
              'Invalid Card'
            else
              'Credit Card Declined'
            end
          end

          private
          # Take the posted data and move the relevant data into a hash
          def parse(post)
            @raw = post.to_s
            for line in @raw.split('&')
              key, value = *line.scan( %r{^([A-Za-z0-9_.]+)\=(.*)$} ).flatten

              if key == 'response_code'
                begin
                  params[key] = Integer(/0*(\d+)/.match(CGI.unescape(value))[1])
                rescue ArgumentError
                  params[key] = nil
                end
              else
                params[key] = CGI.unescape(value)
              end
            end
          end
        end
      end
    end
  end
end
