describe 'Vendor Factory' do
  context '#create' do
    let(:user) { FactoryGirl.create :user }
    it 'creates a vendor' do
      expect { FactoryGirl.create(:vendor, user: user) }.to change(Vendor, :count).by(1)
    end
    context 'association' do
      it 'associates to a user' do
        model = FactoryGirl.create(:vendor, user: user)
        expect(model.user).to eq user
      end
    end
  end
end
