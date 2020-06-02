class RenameMethodColumnToShippings < ActiveRecord::Migration[5.2]
  def change
    rename_column :shippings, :method, :shipping_way
  end
end
