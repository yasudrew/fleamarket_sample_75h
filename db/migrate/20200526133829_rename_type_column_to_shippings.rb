class RenameTypeColumnToShippings < ActiveRecord::Migration[5.2]
  def change
    rename_column :shippings, :type, :method
  end
end
