describe OverviewsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:vendor) { FactoryGirl.create(:vendor, user: user) }
  let(:expense_category) { FactoryGirl.create(:expense_category, user: user) }
  let(:income_category) { FactoryGirl.create(:income_category, user: user) }

  describe '#get_monthly_expense_history' do
    before do
      Timecop.freeze(Date.new(2016,9,22)) do
        5.times do
          FactoryGirl.create(:expense, user: user, vendor: vendor, expense_category: expense_category, amount: 1000, created_at: Time.now.months_ago(3))
        end
        4.times do
          FactoryGirl.create(:expense, user: user, vendor: vendor, expense_category: expense_category, amount: 500, created_at: Time.now.months_ago(2))
        end
        3.times do
          FactoryGirl.create(:expense, user: user, vendor: vendor, expense_category: expense_category, amount: 1000, created_at: Time.now.months_ago(1))
        end
        2.times do
          FactoryGirl.create(:expense, user: user, vendor: vendor, expense_category: expense_category, amount: 1000, created_at: Time.now)
        end
      end
      sign_in user
    end
    it 'sums the expenses for each month' do
      h = controller.get_monthly_expense_history
      expect(h['June']).to eq 5000.0
      expect(h['July']).to eq 2000.0
      expect(h['August']).to eq 3000.0
      expect(h['September']).to eq 2000.0
      expect(h['October']).to eq 0.0
    end
  end

  describe '#get_monthly_income_history' do
    before do
      Timecop.freeze(Date.new(2016,9,22)) do
        5.times do
          FactoryGirl.create(:income, user: user, vendor: vendor, income_category: income_category, amount: 1000, created_at: Time.now.months_ago(3))
        end
        4.times do
          FactoryGirl.create(:income, user: user, vendor: vendor, income_category: income_category, amount: 500, created_at: Time.now.months_ago(2))
        end
        3.times do
          FactoryGirl.create(:income, user: user, vendor: vendor, income_category: income_category, amount: 1000, created_at: Time.now.months_ago(1))
        end
        2.times do
          FactoryGirl.create(:income, user: user, vendor: vendor, income_category: income_category, amount: 1000, created_at: Time.now)
        end
      end
      sign_in user
    end
    it 'sums the expenses for each month' do
      h = controller.get_monthly_income_history
      expect(h['June']).to eq 5000.0
      expect(h['July']).to eq 2000.0
      expect(h['August']).to eq 3000.0
      expect(h['September']).to eq 2000.0
      expect(h['October']).to eq 0.0
    end
  end

  describe '#get_monthly_profit_history' do
    before do
      Timecop.freeze(Date.new(2016,9,22)) do
        # expenses
        5.times do
          FactoryGirl.create(:expense, user: user, vendor: vendor, expense_category: expense_category, amount: 1000, created_at: Time.now.months_ago(3))
        end
        4.times do
          FactoryGirl.create(:expense, user: user, vendor: vendor, expense_category: expense_category, amount: 500, created_at: Time.now.months_ago(2))
        end
        3.times do
          FactoryGirl.create(:expense, user: user, vendor: vendor, expense_category: expense_category, amount: 1000, created_at: Time.now.months_ago(1))
        end
        2.times do
          FactoryGirl.create(:expense, user: user, vendor: vendor, expense_category: expense_category, amount: 1000, created_at: Time.now)
        end

        # incomes
        5.times do
          FactoryGirl.create(:income, user: user, vendor: vendor, income_category: income_category, amount: 500, created_at: Time.now.months_ago(3))
        end
        4.times do
          FactoryGirl.create(:income, user: user, vendor: vendor, income_category: income_category, amount: 1000, created_at: Time.now.months_ago(2))
        end
        3.times do
          FactoryGirl.create(:income, user: user, vendor: vendor, income_category: income_category, amount: 500, created_at: Time.now.months_ago(1))
        end
        2.times do
          FactoryGirl.create(:income, user: user, vendor: vendor, income_category: income_category, amount: 500, created_at: Time.now)
        end
      end
      sign_in user
    end

    it 'returns montly profit' do
      expenses = controller.get_monthly_expense_history.values
      incomes = controller.get_monthly_income_history.values
      h = controller.get_monthly_profit_history(expenses, incomes)
      expect(h['May']).to eq 0.0
      expect(h['June']).to eq 2500.0
      expect(h['July']).to eq -2000.0
      expect(h['August']).to eq 1500.0
      expect(h['September']).to eq 1000.0
      expect(h['October']).to eq 0.0
    end
  end
end
