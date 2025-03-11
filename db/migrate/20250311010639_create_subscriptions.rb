class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.decimal :price
      t.string :description
      t.integer :users_subscribed

      t.timestamps
    end
  end
end
