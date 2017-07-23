require_relative './pricing_calculator'

module JobCheckout
  class Item
    attr_reader :ad_name, :quantity, :cart

    def initialize(ad_name, cart)
      @ad_name = ad_name
      @cart = cart
      @quantity = 0
    end

    def increase_quantity
      @quantity += 1
    end

    def total_price
      JobCheckout::PricingCalculator.new(
        customer: self.cart.customer,
        cart: self.cart,
        item: self,
      ).run
    end
  end
end
