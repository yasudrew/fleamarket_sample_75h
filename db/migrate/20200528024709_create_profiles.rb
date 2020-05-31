class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :family_name,          null:false, default: ""
      t.string :first_name,           null:false, default: ""
      t.string :family_name_kana,     null:false, default: ""
      t.string :first_name_kana,      null:false, default: ""
      t.date :birth_day,              null:false, default: 0
      t.string :post_code,            null:false, default: "", optional: true
      t.string :prefecture,           null:false, default: ""
      t.string :city,                 null:false, default: ""
      t.string :address,              null:false, default: ""
      t.string :building_name
      t.integer :user_id,             null:false, foreign_key: true

      t.timestamps
    end
  end
end
