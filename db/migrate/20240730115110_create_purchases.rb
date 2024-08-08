class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.references :user, foreign_key: { to_table: :users }
      t.references :item, foreign_key: true
      t.timestamps
    end
  end
end
