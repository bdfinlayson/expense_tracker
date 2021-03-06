describe Recurrence do
  let(:user) { FactoryGirl.create :user }
  let(:vendor) { FactoryGirl.create(:vendor, user: user)}

  context 'biweekly (frequency = 1)' do
    let(:income_category) { FactoryGirl.create(:income_category, user: user)}
    let(:recurring_income) { FactoryGirl.create(:recurring_income,
      created_at: Date.new(2016,9,1),
      user: user,
      vendor: vendor,
      income_category: income_category,
      frequency: 1)
    }
    context 'when due first time in month' do
      context 'month created' do
        it 'creates item' do
          Timecop.freeze(Date.new(2016,9,1)) do
            expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(1)
          end
        end
        context 'a day late' do
          it 'creates item' do
            Timecop.freeze(Date.new(2016,9,2)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(1)
            end
            Timecop.freeze(Date.new(2016,9,2)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
          end
        end
        context '14 days later' do
          it 'creates second item' do
            Timecop.freeze(Date.new(2016,9,1)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(1)
            end

            Timecop.freeze(Date.new(2016,9,1) + 14) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(1)
            end
          end
        end
        context 'days in between first time' do
          before do
            Timecop.freeze(Date.new(2016,9,1)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(1)
            end
          end
          it 'does not create an item' do
            Timecop.freeze(Date.new(2016,9,1)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,9,2)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,9,3)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,9,4)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,9,10)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,9,13)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,9,14)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
          end
        end
        context 'days in between second time' do
          before do
            Timecop.freeze(Date.new(2016,9,1)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(1)
            end
            Timecop.freeze(Date.new(2016,9,1) + 14) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(1)
            end
          end
          it 'does not create an item' do
            Timecop.freeze(Date.new(2016,9,15)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,9,16)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,9,17)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,9,18)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,9,25)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,9,29)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,9,30)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
          end
        end
      end
      context 'a month later' do
        context 'days in between first time' do
          before do
            Timecop.freeze(Date.new(2016,9,1)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(1)
            end
            Timecop.freeze(Date.new(2016,9,15)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(1)
            end

            Timecop.freeze(Date.new(2016,10,1)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(1)
            end
          end
          it 'does not create an item' do
            Timecop.freeze(Date.new(2016,10,1)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,10,2)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,10,3)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,10,4)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,10,10)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,10,13)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,10,14)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
          end
        end
        context 'days in between second time' do
          before do
            Timecop.freeze(Date.new(2016,10,1)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(1)
            end
            Timecop.freeze(Date.new(2016,10,1) + 14) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(1)
            end
          end
          it 'does not create an item' do
            Timecop.freeze(Date.new(2016,10,15)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,10,16)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,10,17)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,10,18)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,10,25)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,10,29)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
            Timecop.freeze(Date.new(2016,10,30)) do
              expect{Recurring.new(recurring_income).compute}.to change(Income, :count).by(0)
            end
          end
        end
      end
    end
  end

  context 'monthly (frequency = 2)' do
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
          expect{Recurring.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(1)
          Timecop.freeze(Date.today + 1.month) do
            expect{Recurring.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(1)
          end
          expect(PendingExpense.unscoped.count).to be 2
        end
      end

      context 'when a year later' do
        it 'creates a pending expense' do
          current_date = Date.today
          Timecop.freeze(current_date) do
            expect{Recurring.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(1)
          end
          Timecop.freeze(current_date + 1.year) do
            expect{Recurring.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(1)
          end
        end
      end

      context 'when duplicate' do
        context 'on same day' do
          it 'does not create' do
            expect{Recurring.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(1)
            expect{Recurring.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(0)
            expect(PendingExpense.unscoped.count).to be 1
          end
        end
        context 'in the following month after logging the first time the item was due' do
          before do
            expect{Recurring.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(1)
            Timecop.freeze(Date.today + 1.month) do
              expect{Recurring.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(1)
            end
          end
          it 'does not create again on the following day' do
            Timecop.freeze(Date.today + 1.month + 1.day) do
              expect{Recurring.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(0)
            end
            Timecop.freeze(Date.today + 1.month + 2.days) do
              expect{Recurring.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(0)
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
        Timecop.freeze(2016,10,1) do
          expect{Recurring.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(0)
        end
        Timecop.freeze(2016,10,5) do
          expect{Recurring.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(0)
        end
        Timecop.freeze(2016,10,10) do
          expect{Recurring.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(1)
        end
        Timecop.freeze(2016,10,11) do
          expect{Recurring.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(0)
        end
        Timecop.freeze(2016,10,25) do
          expect{Recurring.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(0)
        end
      end
    end
  end

  context 'when annual (frequency = 3)' do
    let(:expense_category) { FactoryGirl.create(:expense_category, user: user)}
    let(:time) { DateTime.new(2016,5,5) }
    let!(:recurring_expense) {
      FactoryGirl.create(:recurring_expense,
        created_at: time,
        user: user,
        vendor: vendor,
        expense_category: expense_category,
        frequency: 3)
    }

    context 'when not due' do
      before do
        Timecop.freeze(time) do
          expect{Recurring.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(1)
        end
      end

      it 'does not log in same year' do
        Timecop.freeze(time.tomorrow) do
          expect{Recurring.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(0)
        end
      end

      it 'does not log in next year before month due' do
        Timecop.freeze(time.next_year.beginning_of_year) do
          expect{Recurring.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(0)
        end
      end
    end

    context 'when due' do
      before do
        Timecop.freeze(time) do
          expect{Recurring.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(1)
        end
      end


      it 'logs' do
        Timecop.freeze(time.next_year) do
          expect{Recurring.new(recurring_expense).compute}.to change(PendingExpense.unscoped, :count).by(1)
        end
      end
    end
  end
end
