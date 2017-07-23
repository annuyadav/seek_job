require 'spec_helper'
require_relative '../lib/customer'

RSpec.describe JobCheckout::Customer do

  let(:names) { %w(default Unilever Apple Nike) }

  describe 'initialize' do
    it 'initiates a customer object' do
      names.each do |name|
        customer = JobCheckout::Customer.new(name)
        expect(customer.name).to eq name
      end
    end
  end
end

