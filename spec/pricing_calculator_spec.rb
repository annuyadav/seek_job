require 'spec_helper'
require_relative '../lib/pricing_calculator'

RSpec.describe JobCheckout::PricingCalculator do

  let(:customer) { JobCheckout::Customer.new('default') }
  let(:cart) { JobCheckout::Cart.new(customer) }
  let(:item) { JobCheckout::Item.new('nike', cart) }

  describe 'initialize' do
    it 'initiates item object' do
      pricing_calculator = JobCheckout::PricingCalculator.new(customer: customer, cart: cart, item: item)
      expect(pricing_calculator.plan).to eq :default
      expect(pricing_calculator.cart).to eq cart
      expect(pricing_calculator.item).to eq item
      expect(pricing_calculator.total_item_count).to eq 0
    end
  end
end