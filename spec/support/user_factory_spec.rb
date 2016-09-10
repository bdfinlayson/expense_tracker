require 'spec_helper'

describe 'User Factory' do
  context 'creating users' do
    it 'is valid' do
      model = FactoryGirl.build(:user)
      expect(model.valid?).to be true
    end
    it 'creates a user' do
      expect{FactoryGirl.create(:user)}.to change(User, :count).by(1)
    end
  end
end
