desc "This task is for creating new expense/income line items and is run on a daily basis at 4 a.m. (9 a.m. UTC) by the Heroku scheduler add-on"
task :recurrence => :environment do
  RecurringExpense.active.each do |expense|
    Recurring.new(expense).compute
  end

  RecurringIncome.all.each do |income|
    Recurring.new(income).compute
  end
end
