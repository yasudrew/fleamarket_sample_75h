class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :family_name,          null:false
      t.string :first_name,           null:false
      t.string :family_name_kana,     null:false
      t.string :first_name_kana,      null:false
      t.date :birth_day,              null:false
      t.string :post_code,            null:false
      t.string :prefecture,           null:false
      t.string :city,                 null:false
      t.string :address,              null:false
      t.string :building_name
      t.integer :user_id,             null:false, foreign_key: true

      t.timestamps
    end
  end
end
