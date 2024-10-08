class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :product, null: false, foreign_key: { to_table: :items }
      t.timestamps
    end
  end
end
