class AddStatusToCoupon < ActiveRecord::Migration[6.1]
  def change
    add_column :coupons, :status, :integer
  end
end
