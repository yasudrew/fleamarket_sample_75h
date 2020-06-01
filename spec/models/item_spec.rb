require 'rails_helper'

describe Item do
  describe '#create' do

    it "name,description,status,price,fee,profit,category_id,brand_id,user_id,shipping_idが存在すれば登録できること" do
      item = build(:image)
      expect(item).to be_valid
    end

    it "nameがない場合は登録できないこと" do
      item = build(:item, name: "")
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "descriptionがない場合は登録できないこと" do
      item = build(:item, description: "")
      item.valid?
      expect(item.errors[:description]).to include("を入力してください")
    end

    it "statusがない場合は登録できないこと" do
      item = build(:item, status: "")
      item.valid?
      expect(item.errors[:status]).to include("を入力してください")
    end

    it "priceがない場合は登録できないこと" do
      item = build(:item, price: "")
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

    it "feeがない場合は登録できないこと" do
      item = build(:item, fee: "")
      item.valid?
      expect(item.errors[:fee]).to include("を入力してください")
    end

    it "profitがない場合は登録できないこと" do
      item = build(:item, profit: "")
      item.valid?
      expect(item.errors[:profit]).to include("を入力してください")
    end


    it "user_idがない場合は登録できないこと" do
      item = build(:item, user_id: "")
      item.valid?
      expect(item.errors[:user]).to include("を入力してください")
    end

    it "shipping_idがない場合は登録できないこと" do
      item = build(:item, shipping_id: "")
      item.valid?
      expect(item.errors[:shipping]).to include("を入力してください")
    end

    it "nameが20文字より多いと登録できないこと" do
      item = build(:item, name: "#{'a' * 21}")
      item.valid?
      expect(item.errors[:name]).to include("は20文字以内で入力してください")
    end

    it "descriptionが1000文字より多いと登録できないこと" do
      item = build(:item, description: "#{'a' * 1001}")
      item.valid?
      expect(item.errors[:description]).to include("は1000文字以内で入力してください")
    end


    it "priceが299以下だと登録できないこと" do
      item = build(:item, price: "299")
      item.valid?
      expect(item.errors[:price]).to include("は300以上の値にしてください")
    end


  end
end