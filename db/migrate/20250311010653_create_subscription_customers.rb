class CreateSubscriptionCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :subscription_customers do |t|
      t.references :subscription, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.boolean :status

      t.timestamps
    end
  end
end
