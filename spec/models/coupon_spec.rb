require 'rails_helper'

RSpec.describe Coupon, type: :model do
    describe 'associations' do
        it { should belong_to(:promotion).class_name('Promotion') }
      end
end
