desc "This task is for creating new expense/income line items and is run on a daily basis at 4 a.m. (9 a.m. UTC) by the Heroku scheduler add-on"
task :recurrence => :environment do
  newly_logged_expenses = []
  newly_logged_incomes = []
  RecurringExpense.all.each do |e|
    newly_logged_expenses.push Recurrence.new(e).compute
  end
  RecurringIncome.all.each do |i|
    newly_logged_incomes.push Recurrence.new(i).compute
  end
end
