describe 'Expense Category Factory' do
  context '#create' do
    let(:user) { FactoryGirl.create :user }
    it 'creates a category' do
      expect{ FactoryGirl.create(:expense_category, user: user) }.to change(ExpenseCategory, :count).by(1)
    end
    context 'associations' do
      it 'belongs to a user' do
        model = FactoryGirl.create(:expense_category, user: user)
        expect(model.user).to eq user
      end
    end
  end
end
