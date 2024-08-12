class RenameProductIdToItemIdInPurchases < ActiveRecord::Migration[7.0]
  def change
    rename_column :purchases, :product_id, :item_id
  end
end
