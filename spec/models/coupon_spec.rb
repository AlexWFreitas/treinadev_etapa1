require 'rails_helper'

describe Coupon do
    describe 'associations' do
        it { should belong_to(:promotion).class_name('Promotion') }
      end
end
