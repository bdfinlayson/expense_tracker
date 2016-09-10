describe 'Pending Expense Factory' do
  context '#create' do
    let(:user) { FactoryGirl.create :user }
    let(:vendor) { FactoryGirl.create(:vendor, user: user)}
    let(:expense_category) { FactoryGirl.create(:expense_category, user: user)}
    let(:recurring_expense) {
      FactoryGirl.create(:recurring_expense,
        user: user,
        vendor: vendor,
        expense_category: expense_category)
    }
    it 'creates a pending expense' do
      expect { FactoryGirl.create(:pending_expense,
        user: user,
        vendor: vendor,
        expense_category: expense_category,
        recurring_expense: recurring_expense
        )}.to change(PendingExpense, :count).by(1)
    end
    context 'associations' do
      let(:pending_expense) { FactoryGirl.create(:pending_expense,
        user: user,
        vendor: vendor,
        expense_category: expense_category,
        recurring_expense: recurring_expense
        )}
      it 'belongs to a user' do
        expect(pending_expense.user).to eq user
      end
      it 'belongs to a expense category' do
        expect(pending_expense.expense_category).to eq expense_category
      end
      it 'belongs to a vendor' do
        expect(pending_expense.vendor).to eq vendor
      end
      it 'belongs to a recurring expense' do
        expect(pending_expense.recurring_expense).to eq recurring_expense
      end
    end
  end
end
