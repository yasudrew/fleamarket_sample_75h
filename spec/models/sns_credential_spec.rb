require 'rails_helper'

describe "sns_credential" do
  describe '#create' do

    it "provider,uid,user_idがあれば登録できること" do
      sns_credential = build(:sns_credential)
      expect(sns_credential).to be_valid
    end

    it "providerがない場合は登録できないこと" do
      sns_credential = build(:sns_credential, provider: "")
      sns_credential.valid?
      expect(sns_credential.errors[:provider])
    end

    it "uidがない場合は登録できないこと" do
      sns_credential = build(:sns_credential, uid: "")
      sns_credential.valid?
      expect(sns_credential.errors[:uid])
    end

    it "user_idがない場合は登録できないこと" do
      sns_credential = build(:sns_credential, user_id: "")
      sns_credential.valid?
      expect(sns_credential.errors[:user_id])
    end
  end
end