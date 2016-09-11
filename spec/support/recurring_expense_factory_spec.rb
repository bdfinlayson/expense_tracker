describe 'Recurring Expense Factory' do
  context '#create' do
    let(:user) { FactoryGirl.create :user }
    let(:vendor) { FactoryGirl.create(:vendor, user: user)}
    let(:expense_category) { FactoryGirl.create(:expense_category, user: user)}
    it 'creates a recurring expense' do
      expect{ FactoryGirl.create(:recurring_expense,
        user: user,
        vendor: vendor,
        expense_category: expense_category)
      }.to change(RecurringExpense, :count).by(1)
    end
    context 'associations' do
      let(:recurring_expense) {
        FactoryGirl.create(:recurring_expense,
          user: user,
          vendor: vendor,
          expense_category: expense_category)
      }
      it 'belongs to a user' do
        expect(recurring_expense.user).to eq user
      end
      it 'belongs to a expense category' do
        expect(recurring_expense.expense_category).to eq expense_category
      end
      it 'belongs to a vendor' do
        expect(recurring_expense.vendor).to eq vendor
      end
    end
  end
end
