desc "This task is for creating new expense/income line items and is called on a daily basis by the Heroku scheduler add-on"
task :recurrence => :environment do
  puts "Checking for unlogged recurring line items..."
  newly_logged_items = []
  RecurringExpense.all.each do |e|
    newly_logged_items.push Recurrence.new(e).compute
  end
  new_items = newly_logged_items.compact.count
  puts "Done. Logged #{new_items} new line items."
end
