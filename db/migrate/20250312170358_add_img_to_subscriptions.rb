class AddImgToSubscriptions < ActiveRecord::Migration[7.1]
  def change
    add_column :subscriptions, :img, :string
  end
end
