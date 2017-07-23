require_relative './lib/cart'
require_relative './lib/customer'

module JobCheckout
  class Calculate

    def initialize(customer: nil, ads_added: [])
      @customer = JobCheckout::Customer.new(customer.strip)
      @ads = ads_added.split(',').map{|ad| ad.strip}
      @cart = JobCheckout::Cart.new(@customer)
    end

    def execute
      @ads.each do |ad_name|
        @cart.add_item ad_name
      end
      puts @cart.total_price
    end
  end
end