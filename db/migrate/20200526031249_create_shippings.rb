class CreateShippings < ActiveRecord::Migration[5.2]
  def change
    create_table :shippings do |t|
      t.integer :burden, null:false
      t.integer :type, null:false
      t.integer :area, null:false
      t.integer :day, null:false

      t.timestamps
    end
  end
end
