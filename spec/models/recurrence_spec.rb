describe Recurrence do
  context 'monthly (frequency = 2)' do
    let(:user) { FactoryGirl.create :user }
    let(:vendor) { FactoryGirl.create(:vendor, user: user)}
    let(:expense_category) { FactoryGirl.create(:expense_category, user: user)}
    let!(:recurring_expense) {
      FactoryGirl.create(:recurring_expense,
        created_at: Time.now,
        user: user,
        vendor: vendor,
        expense_category: expense_category,
        frequency: 2)
    }

    context 'when due' do
      context 'a month later' do
        it 'creates a pending expense' do
          expect{Recurrence.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(1)
          Timecop.freeze(Date.today + 31) do
            expect{Recurrence.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(1)
          end
          expect(PendingExpense.unscoped.count).to be 2
        end
      end
      context 'when duplicate' do
        context 'on same day' do
          it 'does not create' do
            expect{Recurrence.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(1)
            expect{Recurrence.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(0)
            expect(PendingExpense.unscoped.count).to be 1
          end
        end
        context 'in the following month after logging the first time the item was due' do
          before do
            expect{Recurrence.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(1)
            Timecop.freeze(Date.today + 31) do
              expect{Recurrence.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(1)
            end
          end
          it 'does not create again on the following day' do
            Timecop.freeze(Date.today + 32) do
              expect{Recurrence.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(0)
            end
            Timecop.freeze(Date.today + 33) do
              expect{Recurrence.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(0)
            end
            expect(PendingExpense.unscoped.count).to be 2
          end
        end
      end
    end
    context 'when not due' do
      it 'does not log till due' do
        # Time (yyyy, mm, dd)
        # Timecop.freeze (yyyy, mm, dd)
        recurring_expense.update(created_at: Time.new(2016,9,10))
        expect{Recurrence.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(1)
        Timecop.freeze(2016,10,1) do
          expect{Recurrence.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(0)
        end
        Timecop.freeze(2016,10,5) do
          expect{Recurrence.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(0)
        end
        Timecop.freeze(2016,10,10) do
          expect{Recurrence.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(1)
        end
        Timecop.freeze(2016,10,11) do
          expect{Recurrence.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(0)
        end
        Timecop.freeze(2016,10,25) do
          expect{Recurrence.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(0)
        end
      end
    end
  end
end
