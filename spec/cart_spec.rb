require 'spec_helper'
require_relative '../lib/cart'
require_relative '../lib/customer'

RSpec.describe JobCheckout::Cart do

  let(:customer) { JobCheckout::Customer.new('nike') }
  let(:cart) { 'ABC-123' }

  describe 'initialize' do
    it 'initiates cart object' do
      cart = JobCheckout::Cart.new(customer)
      expect(cart.customer).to eq customer
      expect(cart.total_item_count).to eq 0
      expect(cart.total_price).to eq 0
    end
  end

  describe 'add_item' do
    let(:cart) { JobCheckout::Cart.new(customer) }
    let(:ad) { 'premium' }
    it 'add item to cart' do
      cart.add_item(ad)
      expect(cart.total_item_count).to eq 1
      expect(cart.total_price).to eq 394.99
    end
  end
end