describe Recurrence do
  context 'monthly (frequency = 2)' do
    context 'when due' do
      let(:user) { FactoryGirl.create :user }
      let(:vendor) { FactoryGirl.create(:vendor, user: user)}
      let(:expense_category) { FactoryGirl.create(:expense_category, user: user)}
      let!(:recurring_expense) {
        FactoryGirl.create(:recurring_expense,
          user: user,
          vendor: vendor,
          expense_category: expense_category,
          frequency: 2)
      }

      before do
        Recurrence.new(recurring_expense).compute
      end

      it 'creates a pending expense' do
        Timecop.freeze(Date.today + 31) do
          expect{Recurrence.new(recurring_expense).compute}.to change(PendingExpense, :count).by(1)
        end
      end
      context 'when duplicate' do
        it 'does not create' do

        end
      end
    end
    context 'when not due' do

    end
  end
end
