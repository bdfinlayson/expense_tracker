describe 'User Factory' do
  context '#build' do
    it 'is valid' do
      model = FactoryGirl.build(:user)
      expect(model.valid?).to be true
    end
  end
  context '#create' do
    it 'creates a user' do
      expect{FactoryGirl.create(:user)}.to change(User, :count).by(1)
    end
  end
end
