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
      t.references :user, type: :bigint, foreign_key: true

      t.timestamps
    end
  end
end
