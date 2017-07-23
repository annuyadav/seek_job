require 'spec_helper'
require_relative '../lib/item'
require_relative '../lib/cart'
require_relative '../lib/customer'

RSpec.describe JobCheckout::Item do

  let(:customer) { JobCheckout::Customer.new('nike') }
  let(:cart) { JobCheckout::Cart.new(customer) }

  describe 'initialize' do
    it 'initiates item object' do
      item = JobCheckout::Item.new('standout', cart)
      expect(item.ad_name).to eq 'standout'
      expect(item.cart).to eq cart
      expect(item.quantity).to eq 0
    end
  end

  describe 'increase_quantity' do
    let(:item){ JobCheckout::Item.new('standout', cart) }
    it 'increase quantity count' do
      expect{ item.increase_quantity }.to change{ item.quantity }.from(0).to(1)
    end
  end

  describe 'total_price' do
    context 'when customer is default customer' do
      let(:customer) { JobCheckout::Customer.new('default') }
      let(:cart) { JobCheckout::Cart.new(customer) }
      it 'doesnt apply some special pricing' do
        item = cart.add_item 'standout'
        expect(item.quantity).to eq 1
        expect(item.total_price).to eq 322.99
        3.times { item.increase_quantity }
        expect(item.quantity).to eq 4
        expect(item.total_price).to eq 1291.96
      end
    end
    context 'when customer is unilever customer' do
      let(:customer) { JobCheckout::Customer.new('unilever') }
      let(:cart) { JobCheckout::Cart.new(customer) }
      it 'doesnt apply some special pricing if count is not reached' do
        line_item = cart.add_item 'classic'
        expect(line_item.quantity).to eq 1
        expect(line_item.total_price).to eq 269.99
      end
      it 'apply some special pricing if count is not reached' do
        line_item = cart.add_item 'classic'
        2.times { line_item.increase_quantity }
        expect(line_item.quantity).to eq 3
        expect(line_item.total_price).to eq 539.98
      end
    end
    context 'when customer is apple customer' do
      let(:customer) { JobCheckout::Customer.new('apple') }
      let(:cart) { JobCheckout::Cart.new(customer) }
      it 'doesnt apply some special pricing if count is not reached' do
        line_item = cart.add_item 'standout'
        expect(line_item.quantity).to eq 1
        expect(line_item.total_price).to eq 299.99
      end
      it 'apply some special pricing if count is not reached' do
        line_item = cart.add_item 'standout'
        2.times { line_item.increase_quantity }
        expect(line_item.quantity).to eq 3
        expect(line_item.total_price).to eq 899.97
      end
    end
    context 'when customer is nike customer' do
      let(:customer) { JobCheckout::Customer.new('nike') }
      let(:cart) { JobCheckout::Cart.new(customer) }
      it 'doesnt apply some special pricing if count is not reached' do
        line_item = cart.add_item 'premium'
        expect(line_item.quantity).to eq 1
        expect(line_item.total_price).to eq 394.99
      end
      it 'apply some special pricing if count is not reached' do
        line_item = cart.add_item 'premium'
        3.times { line_item.increase_quantity }
        expect(line_item.quantity).to eq 4
        expect(line_item.total_price).to eq 1519.96
      end
    end
  end
end