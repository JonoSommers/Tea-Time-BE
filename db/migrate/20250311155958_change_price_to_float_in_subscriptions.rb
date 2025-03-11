class ChangePriceToFloatInSubscriptions < ActiveRecord::Migration[7.1]
  def change
    change_column :subscriptions, :price, :float
  end
end
