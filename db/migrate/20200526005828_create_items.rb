class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :status, null: false
      t.integer :price, null: false
      t.integer :fee, null: false
      t.integer :profit, null: false
      t.integer :buyer_id
      t.references :user, type: :integer, foreign_key: true
      t.references :category, type: :integer, foreign_key: true
      t.references :brand, type: :integer, foreign_key: true
      t.references :shipping, type: :integer, foreign_key: true

      t.timestamps
    end
  end
end
