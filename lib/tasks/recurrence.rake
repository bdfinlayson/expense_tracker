desc "This task is for creating new expense/income line items and is run on a daily basis at 4 a.m. (9 a.m. UTC) by the Heroku scheduler add-on"
task :recurrence => :environment do
  puts "Checking for unlogged recurring line items..."
  newly_logged_expenses = []
  newly_logged_incomes = []
  RecurringExpense.all.each do |e|
    newly_logged_expenses.push Recurrence.new(e).compute
  end
  RecurringIncome.all.each do |i|
    newly_logged_incomes.push Recurrence.new(i).compute
  end
  new_expense_items = newly_logged_expenses.compact.count
  new_income_items = newly_logged_incomes.compact.count
  puts "Done. Logged #{new_expense_items} new expense line items. Logged #{new_income_items} new income line items."
end
