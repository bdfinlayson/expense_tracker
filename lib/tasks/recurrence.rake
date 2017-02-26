desc "This task is for creating new expense/income line items and is run on a daily basis at 4 a.m. (9 a.m. UTC) by the Heroku scheduler add-on"
task :recurrence => :environment do
  def recurring(resource)
    case resource.frequency
    when :weekly
    when :biweekly
      Recurrence.new(resource).extend(BiweeklyRecurrence).compute
    when :monthly
      # Recurrence.new(resource).extend(MonthlyRecurrence).compute
      Recurrence.new(resource).compute
    when :annually
      # Recurrence.new(resource).extend(YearlyRecurrence).compute
      Recurrence.new(resource).compute
    end
  end

  RecurringExpense.active.each do |expense|
    # Recurrence.new(e).compute
    recurring expense
  end

  RecurringIncome.all.each do |income|
    # Recurrence.new(i).compute
    recurring income
  end
end
