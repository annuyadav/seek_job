module JobCheckout
  class PricingCalculator
    attr_reader :item, :customer, :cart, :plan, :total_item_count

    PRICINGS = {
      default: {
        classic: 269.99,
        standout: 322.99,
        premium: 394.99,
      },
      unilever: {
        classic: {original_count: 3, applicable_count: 2, type: :count}
      },
      apple: {
        standout: {applicable_price: 299.99, type: :price},
      },
      nike: {
        premium: {applicable_price: 379.99, type: :price, total_order_count: 4},
      },
      ford:
      {
        classic: {original_count: 5, applicable_count: 4, type: :count},
        standout: {applicable_price: 309.99, type: :price},
        premium: {applicable_price: 389.99, type: :price, total_order_count: 3},
      }
    }

    def initialize(customer:, cart:, item:)
      @plan = customer.name.downcase.to_sym
      @cart = cart
      @item = item
      @total_item_count = cart.total_item_count.to_i
    end

    def run
      return default_pricing * item.quantity if PRICINGS[plan].nil?
      return default_pricing if plan == :default
      plan_pricing
    end

    private

    def plan_pricing
      ad_pricing = PRICINGS[plan][item.ad_name.to_sym]
      return default_pricing if ad_pricing.nil?
      return default_pricing if ad_pricing[:total_order_count].to_i > total_item_count
      send("discount_by_#{ad_pricing[:type]}", ad_pricing)
    end

    def discount_by_count(ad_pricing)
      new_count = (item.quantity/ad_pricing[:original_count])*ad_pricing[:applicable_count] +
       (item.quantity % ad_pricing[:original_count])
      return (new_count * default_price)
    end

    def discount_by_price(ad_pricing)
      ad_pricing[:applicable_price] * item.quantity
    end

    def default_pricing
      default_price * item.quantity
    end

    def default_price
      PRICINGS[:default][item.ad_name.to_sym]
    end
  end
end
