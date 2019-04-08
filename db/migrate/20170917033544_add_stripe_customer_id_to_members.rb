class AddStripeCustomerIdToMembers < ActiveRecord::Migration[4.2]
  def change
    add_column :members, :stripe_customer_id, :string
  end
end
