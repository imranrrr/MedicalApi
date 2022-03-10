class AddStripeAccountToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :paid, :boolean, default: :false
    add_column :users, :stripe_account_intent, :string
  end
end
