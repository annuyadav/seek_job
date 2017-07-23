require_relative './item'

module JobCheckout
  class Cart

    attr_reader :items, :customer

    def initialize(customer)
      @customer = customer
      @items = {}
    end

    def total_item_count
      return 0 if @items.empty?
      @items.map {|_, item| item.quantity }.inject(:+)
    end

    def total_price
      return 0.0 if @items.empty?
      @items.map {|_, item| item.total_price }.inject(:+).round(2)
    end

    def add_item(ad_name)
      unless item = @items[ad_name]
        item = JobCheckout::Item.new(ad_name, self)
        @items[ad_name] = item
      end
      item.increase_quantity
      item
    end
  end
end